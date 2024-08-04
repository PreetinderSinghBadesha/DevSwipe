import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class CompanyData {
  final String name;
  final String imageUrl;
  final String job;

  CompanyData({required this.imageUrl, required this.name, required this.job});

  factory CompanyData.fromDocument(DocumentSnapshot doc) {
    return CompanyData(
      imageUrl: doc['imageUrl'],
      name: doc['name'],
      job: doc['job'],
    );
  }
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List<CompanyData> fav = [
      CompanyData(
        imageUrl:
            'https://res.cloudinary.com/dko0tsv0x/image/upload/v1722442704/tech%20week/crxbpkt2diatcv3n0sby.png',
        name: 'Master Card',
        job: 'Software Developer',
      ),
      CompanyData(
        imageUrl:
            'https://inkbotdesign.com/wp-content/uploads/2023/08/nvidia-logo-design-tech-company-1024x536.webp',
        name: 'Nvidia',
        job: 'Robotics Engineer',
      ),
    ];

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fav",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width / 15,
                    ),
                  ),
                  Image.asset(
                    "assets/Vector.png",
                    width: 30,
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: height,
              child: fav.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: height / 2,
                      child: CardSwiper(
                        cardsCount: fav.length,
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
                                      fav[index].imageUrl,
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
                                            fav[index].name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            fav[index].job,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
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
