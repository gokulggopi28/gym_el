import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/member_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading =false;
  bool get isLoading =>_isLoading;
  String? _uid;
  String get uid =>_uid!;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedIn") ?? false;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);

          },
          verificationFailed: (error){
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken){
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => MyOtp(
                    verificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: (verificationId){});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context,e.message.toString());
    }
  }

  //verify otp
  void verifyotp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,

  }) async {
    _isLoading = true;
    notifyListeners();

    try{
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      if(user!= null){
        _uid = user.uid;
        onSuccess();

      }
      _isLoading = false;
      notifyListeners();

    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    }
    else {
      print("NEW USER");
      return false;
    }
  }
}
