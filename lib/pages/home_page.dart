import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:jobify/models/user_model.dart';
import 'package:jobify/pages/profile_page.dart';
import 'package:jobify/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class QuarterCirclePainter extends CustomPainter {
  final Color color;
  final bool isTopRight;

  QuarterCirclePainter({required this.color, required this.isTopRight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isTopRight) {
      path.moveTo(size.width, 0);
      path.arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.width),
        clockwise: false,
      );
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, size.height);
      path.arcToPoint(
        Offset(size.width, size.height),
        radius: Radius.circular(size.width),
        clockwise: false,
      );
      path.lineTo(0, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? _userModel;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchUserDetails();
    }
  }

  Future<void> _fetchUserDetails() async {
    if (user != null) {
      final userId = user!.uid;
      _databaseService.getUserDetails(userId).listen((snapshot) {
        if (snapshot.exists) {
          setState(() {
            _userModel = snapshot.data();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: -width / 3,
              left: -width / 3,
              child: CustomPaint(
                size: Size(width / 1.5, width / 1.5),
                painter: QuarterCirclePainter(
                  color: const Color.fromRGBO(28, 46, 76, 1),
                  isTopRight: false,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width / 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(userDetails:_userModel!),
                        ),
                      );
                    },
                    child: Image.network(
                      user!.photoURL ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      width: 30,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: height,
              child: true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: height / 2,
                      child: CardSwiper(
                        cardsCount: 0,
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
                            color: const Color.fromRGBO(73, 109, 142, 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    height: height / 4,
                                    width: width / 1.5,
                                    margin: EdgeInsets.only(top: width / 4),
                                    child: Image.network(
                                      "jobs[index].imageUrl",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
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
                                            "jobs[index].name",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "jobs[index].job",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {},
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
