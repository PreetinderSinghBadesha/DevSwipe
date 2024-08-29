import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobify/models/user_model.dart';
import 'package:jobify/pages/bottom_navbar.dart';
import 'package:jobify/pages/home_page.dart';
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
  TextEditingController readmeController = TextEditingController();

  @override
  void dispose() {
    githubController.dispose();
    linkedinController.dispose();
    readmeController.dispose();
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
          child: SingleChildScrollView(
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
                  height: height / 10,
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
                SizedBox(
                  height: height / 50,
                ),
                TextField(
                  maxLines: 10,
                  controller: readmeController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ReadMe',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (user != null) {
                      if (_isValidUrl(githubController.text) &&
                          _isValidUrl(linkedinController.text)) {
                        try {
                          // Upload the readme content as a .md file to Firebase Storage
                          String downloadUrl =
                              await _databaseService.uploadReadmeFile(
                            user!.uid,
                            readmeController.text,
                          );

                          // Create a UserModel with the download URL as the readme field
                          UserModel userDetails = UserModel(
                            github: githubController.text,
                            linkedin: linkedinController.text,
                            readme: downloadUrl,
                          );

                          // Save the user details to Firestore
                          _databaseService.addUser(userDetails, user);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('User details updated successfully.'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please enter valid URLs for GitHub and LinkedIn.'),
                          ),
                        );
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavbar()));
                  },
                  child: const Text("Enter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
