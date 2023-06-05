
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_el/screens/member_login.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code= "";

    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff378ad6), Color(0xff2a288a)],
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Image.asset('assets/images/gymc.png',
                  width: 150,
                  height: 150,
                ),

              ),
              SizedBox(
                height: 10,

              ),




              const Text('Phone Verification',style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              SizedBox(
                height: 15,

              ),
              const Text('We need to register your phone before getting started!',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value){
                  code = value;

                },
              ),

              SizedBox(height: 20,),


              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: ElevatedButton(
                      onPressed: () async{
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MemberLogin.verify, smsCode: code);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);

                        }
                        catch(e){
                          print("Wrong otp");

                        }

                      },
                      child: Padding(
                        padding:  EdgeInsets.only(left: 20.0,right: 20.0),
                        child:  Text(
                          'Verify phone number',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),

                    ),
                  )

              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextButton(onPressed: (){
                      Navigator.push(context,  MaterialPageRoute(
                        builder: (context) => MemberLogin(),),
                      );
                      //Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                    }, child: Text('Edit Phone Number ?',
                      style: TextStyle(
                          color: Colors.grey
                      ),)),
                  )
                ],
              ),



            ],
          ),
        ),
      ),

    );
  }
}

