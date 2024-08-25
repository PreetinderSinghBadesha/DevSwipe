import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'dart:math';

// Define the ProjectModel class
class ProjectModel {
  String userId;
  List<String> lang;
  String? description;
  DateTime startDate;
  DateTime? closingDate;
  int members;
  String issuer;
  String projectName;
  String? githubLink;
  String imageUrl;
  int likes;
  String? readme;

  ProjectModel({
    required this.userId,
    required this.lang,
    this.description,
    required this.startDate,
    this.closingDate,
    this.members = 1,
    required this.issuer,
    required this.projectName,
    this.githubLink,
    required this.imageUrl,
    this.likes = 0,
    this.readme,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProjectModel> projects = [];
  User? user;

  @override
  void initState() {
    super.initState();
    _generateMockProjects();
  }

  // Generate random project data
  void _generateMockProjects() {
    final random = Random();
    const projectNames = [
      "AI Research",
      "Flutter App Development",
      "Web Scraping",
      "Blockchain Explorer",
      "Game Development"
    ];
    const issuers = ["Google", "Microsoft", "Apple", "Amazon", "Facebook"];
    const images = [
      "https://firebasestorage.googleapis.com/v0/b/tech-week-4cecb.appspot.com/o/projectImages%2Fproj.jpg?alt=media&token=abb14c1a-3402-4150-8eb1-0f568d286f86",
      "https://firebasestorage.googleapis.com/v0/b/tech-week-4cecb.appspot.com/o/projectImages%2FLinky.jpeg.jpg?alt=media&token=34a3d43f-226d-4f2d-b614-b9e5f7c73393",
      "https://via.placeholder.com/400x300.png?text=Project+3",
      "https://via.placeholder.com/400x300.png?text=Project+4",
      "https://via.placeholder.com/400x300.png?text=Project+5"
    ];
    const langs = [
      ["Dart", "Flutter"],
      ["Python", "Django"],
      ["JavaScript", "React"],
      ["Solidity", "Ethereum"],
      ["C++", "Unreal Engine"]
    ];

    for (int i = 0; i < 5; i++) {
      projects.add(
        ProjectModel(
          userId: "user_${i + 1}",
          lang: langs[i],
          description: "A project on ${projectNames[i]}",
          startDate:
              DateTime.now().subtract(Duration(days: random.nextInt(100))),
          closingDate: random.nextBool()
              ? DateTime.now().add(Duration(days: random.nextInt(100)))
              : null,
          members: random.nextInt(10) + 1,
          issuer: issuers[i],
          projectName: projectNames[i],
          githubLink:
              "https://github.com/user_${i + 1}/${projectNames[i].toLowerCase().replaceAll(" ", "_")}",
          imageUrl: images[i],
          likes: random.nextInt(100),
          readme: "This is the README for ${projectNames[i]}",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/logo_2.png",
                    width: width / 5,
                    height: width / 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to profile page
                    },
                    child: CircleAvatar(
                      radius: width / 20,
                      backgroundImage: NetworkImage(
                        user?.photoURL ??
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: height,
              child: projects.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: height / 2,
                      child: CardSwiper(
                        cardsCount: projects.length,
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.symmetric(
                          vertical: false,
                          horizontal: true,
                        ),
                        isLoop: false,
                        padding: EdgeInsets.symmetric(
                          vertical: width / 4,
                          horizontal: width / 10,
                        ),
                        cardBuilder: (context, index, percentThresholdX,
                                percentThresholdY) =>
                            Container(
                          width: width / 1.2,
                          height: height / 2,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(172, 28, 31, 34),
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(
                                projects[index].imageUrl,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                child: SizedBox(
                                  width: width / 1.2,
                                  height: width / 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            projects[index].projectName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Issuer: ${projects[index].issuer}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Likes: ${projects[index].likes}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            projects[index].likes++;
                                          });
                                        },
                                        child: Container(
                                          width: width / 8,
                                          height: width / 8,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: const Color.fromRGBO(
                                                28, 46, 76, 1),
                                          ),
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
