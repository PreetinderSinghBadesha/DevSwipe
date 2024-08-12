import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  Future<UserCredential?> handleGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      return await auth.signInWithProvider(googleAuthProvider); 
    } catch (error) {
      print(error);
      return null; // Return null if an error occurs
    }
  }
}
