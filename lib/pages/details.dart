import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobify/models/user_model.dart';
import 'package:jobify/services/database_service.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final DatabaseService _databaseService = DatabaseService();

  TextEditingController githubController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();

  @override
  void dispose() {
    githubController.dispose();
    linkedinController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.hasScheme);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(200, 23, 23, 23),
        body: Container(
          padding: EdgeInsets.all(width / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DevSwipe',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              const Text(
                'Edit Details',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height / 5,
              ),
              TextField(
                controller: githubController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Github Link',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              TextField(
                controller: linkedinController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Linkedin Link',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (user != null) {
                    if (_isValidUrl(githubController.text) && _isValidUrl(linkedinController.text)) {
                      UserModel userDetails = UserModel(
                        github: githubController.text,
                        linkedin: linkedinController.text,
                      );
                      _databaseService.addUser(userDetails, user);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter valid URLs for GitHub and LinkedIn.'),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Enter"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
