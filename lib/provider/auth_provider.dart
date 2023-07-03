import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/screens/AdminHome/admin_home.dart';
import 'package:gym_el/member_otp.dart';
import 'package:gym_el/model/user_model.dart';
import 'package:gym_el/screens/memberhome=%3E/home_member.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  String? _role;
  String get role => _role!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedIn") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedIn", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    String adminPhoneNumber = '9567830355';
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          if (phoneNumber == adminPhoneNumber) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenHome()),
            );
            // Perform admin-specific actions here
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeMemberPage()),
            );
          }
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyOtp(
                    verificationId: verificationId,
                  )));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyotp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();

    if (snapshot.exists && snapshot.data() != null) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }


  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Upload image to Firebase storage
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

         DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid!;

        _userModel = userModel;

        // Uploading to database
        _firebaseFirestore
            .collection("users")
            .doc(_uid)
            .set(userModel.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> getDataFromFirestore() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        final Map<String, dynamic>? data =
        snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          _userModel = UserModel(
            name: data['name'],
            email: data['email'],
            createdAt: data['createdAt'],
            bio: data['bio'],
            uid: data['uid'],
            profilePic: data['profilePic'],
            phoneNumber: data['phoneNumber'],

          );

          _uid = _userModel!.uid;
        } else {
          // Handle null data
          print('Data is null');
        }
      } else {
        // Handle non-existent document
        print('Document does not exist');
      }
    } catch (e) {
      // Handle the error
      print('Error getting data from Firestore: $e');
    }
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    if (_userModel != null) {
      await s.setString("user_model", jsonEncode(_userModel!.toMap()));
    } else {
      // Handle the case when userModel is null
      print('userModel is null');
    }
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';

    if (data.isNotEmpty) {
      _userModel = UserModel.fromMap(jsonDecode(data));
      _uid = _userModel!.uid;
    } else {
      // Handle the case when userModel is null or empty
      _userModel = null;
      _uid = null;
      _role = null;
    }

    notifyListeners();
  }


  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}
