import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobify/firebase_options.dart';
import 'package:jobify/pages/bottom_navbar.dart';
import 'package:jobify/pages/home_page.dart';
import 'package:jobify/pages/login_page.dart';
import 'package:jobify/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {

    

    
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckLogin(),
    );
  }
}


class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    authService.auth.authStateChanges().listen((event) {
      setState(() {
        authService.user = event;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    authService.auth.authStateChanges().listen((event) {
      setState(() {
        authService.user = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  authService.user == null ? const LoginPage() : const HomePage();
  }
}