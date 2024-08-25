import 'package:flutter/material.dart';
import 'package:jobify/pages/details.dart';
import 'package:jobify/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/logo_2.png"),
                signinWithGoogle(context)
              ],
            )),
      ),
    );
  }

  GestureDetector signinWithGoogle(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final userCredential = await authService.handleGoogleSignIn();
        if (userCredential != null) {
          // Handle successful sign-in, e.g., navigate to the home page
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.width / 7.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/google.png"),
            Text(
              "Sign in with Google",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width / 20,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
