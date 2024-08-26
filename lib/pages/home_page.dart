import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'dart:math';

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
      "https://firebasestorage.googleapis.com/v0/b/tech-week-4cecb.appspot.com/o/projectImages%2FScreenshot%202024-08-25%20160359.png?alt=media&token=b60cfaea-66e4-42e9-b0b7-657923380aeb",
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
            SizedBox(
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
                        numberOfCardsDisplayed: 2,
                        backCardOffset: Offset(-width / 15, width / 10),
                        padding: EdgeInsets.symmetric(
                          vertical: width / 4,
                          horizontal: width / 10,
                        ),
                        cardBuilder: (context, index, percentThresholdX,
                                percentThresholdY) =>
                            customSwipeableCard(width, height, index),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container customSwipeableCard(double width, double height, int index) {
    return Container(
      width: width / 1.2,
      height: height / 2,
      decoration: BoxDecoration(
        color: const Color.fromARGB(172, 28, 31, 34),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 1.5,
          color: Colors.white,
        ),
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
            top: width / 30,
            right: width / 30,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width / 150,
              ),
              padding: EdgeInsets.symmetric(
                vertical: width / 100,
                horizontal: width / 50,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 160, 49, 215),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Project",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: width / 25,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(1, 1, 1, 0.457),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width / 30,
              ),
              width: width / 1.2,
              height: width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projects[index].projectName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Owner: ${projects[index].issuer}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 25,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: width / 60),
                        SizedBox(
                          width: width / 2,
                          height: width / 13,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return languageCard(width);
                            },
                          ),
                        ),
                      ],
                    ),
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
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 160, 49, 215),
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
    );
  }

  Container languageCard(double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width / 150,
      ),
      padding: EdgeInsets.symmetric(
        vertical: width / 100,
        horizontal: width / 50,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 160, 49, 215),
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "Python",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
