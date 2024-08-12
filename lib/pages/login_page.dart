import 'package:flutter/material.dart';
import 'package:jobify/pages/details.dart';
import 'package:jobify/pages/home_page.dart';
import 'package:jobify/services/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: googleSignInButton(),
        ),
      ),
    );
  }

  Widget googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign in with Google",
          onPressed: () async {
            final userCredential = await authService.handleGoogleSignIn();
            if (userCredential != null) {
              // Handle successful sign-in, e.g., navigate to the home page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DetailsPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
