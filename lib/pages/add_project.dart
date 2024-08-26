import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  User? user;

  final TextEditingController projectcontroller = TextEditingController();
  final TextEditingController langcontroller = TextEditingController();
  final TextEditingController projectlinkcontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController publishDatecontroller = TextEditingController();
  final TextEditingController memberscontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            Positioned(
              top: width / 5,
              right: 0,
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width / 20,
                    ),
                    Text(
                      'Name of Project',
                      style: TextStyle(
                        fontSize: width / 19,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    TextField(

                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField customTextField(
      TextEditingController controller, TextInputType inputType) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: inputType,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(190, 218, 255, 1),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
    );
  }
}
