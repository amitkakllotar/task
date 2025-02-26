import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/SingUp_Screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: ElevatedButton(
        onPressed: () {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          });

        }, child: Icon(CupertinoIcons.right_chevron),
      ),),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              signInWithGoogle(context);
              setState(() {

              });
            },
            child: Container(
              width: 280,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xff438e96),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/logos_google-icon.png", height: 23, width: 24),
                  SizedBox(width: 10),
                  Text(
                    "Sign In With Google",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔹 Google Sign-In Function
Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return; // User canceled sign-in
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // ✅ Navigate to Home Screen after login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  } catch (e) {
    print("Error during Google Sign-In: $e");
  }
}

