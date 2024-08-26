import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:jobify/models/user_model.dart';
import 'package:jobify/pages/details.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  UserModel userDetails;
  ProfilePage({super.key, required this.userDetails});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String? markdownData;

  @override
  void initState() {
    super.initState();
    _fetchReadmeContent();
  }

  Future<void> _fetchReadmeContent() async {
    if (widget.userDetails.readme != null) {
      try {
        final response = await http.get(Uri.parse(widget.userDetails.readme!));
        if (response.statusCode == 200) {
          setState(() {
            markdownData = response.body;
          });
        } else {
          setState(() {
            markdownData = 'Failed to load README content.';
          });
        }
      } catch (e) {
        setState(() {
          markdownData = 'Error loading README content: $e';
        });
      }
    } else {
      setState(() {
        markdownData = 'No README file found.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(200, 23, 23, 23),
          leading: const BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(200, 23, 23, 23),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: height / 50),
              width: width,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: width / 20,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user?.photoURL ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                    ),
                    radius: width / 8.5,
                  ),
                  SizedBox(
                    width: width / 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Hi, ${user?.displayName}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/linkedin.png",
                            height: width / 18,
                          ),
                          SizedBox(
                            width: width / 45,
                          ),
                          SizedBox(
                            width: width / 1.8,
                            child: Text(
                              widget.userDetails.linkedin,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 90,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/github.png",
                            height: width / 18,
                          ),
                          SizedBox(
                            width: width / 45,
                          ),
                          SizedBox(
                            width: width / 1.8,
                            child: Text(
                              widget.userDetails.github,
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: width / 20,
            ),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: markdownData != null
                    ? Markdown(
                        data: markdownData!,
                        styleSheet: MarkdownStyleSheet.fromTheme(
                          Theme.of(context).copyWith(
                            textTheme: Theme.of(context).textTheme.apply(
                                  bodyColor: Colors.white,
                                ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
