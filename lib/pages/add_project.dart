import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final TextEditingController projectcontroller = TextEditingController();
  final TextEditingController langcontroller = TextEditingController();
  final TextEditingController projectlinkcontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController publishDatecontroller = TextEditingController();
  final TextEditingController memberscontroller = TextEditingController();

  Uint8List? pickedImage;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  ),
                ],
              ),
              SizedBox(height: width / 20),
              Text(
                'Name of Project',
                style: TextStyle(
                    fontSize: width / 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: width / 40),
              customTextField(projectcontroller, TextInputType.text, 1),
              SizedBox(height: width / 25),
              Text(
                'Cover Image',
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: width / 25),
              GestureDetector(
                onTap: projectImageGetter,
                child: pickedImage != null
                    ? Container(
                        width: width,
                        height: width / 3,
                        child: Image.memory(pickedImage!),
                      )
                    : Container(
                        width: width,
                        height: width / 3,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(111, 39, 152, 0.8),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: width / 7,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: width / 25,
              ),
              Text(
                "Tech Stack",
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: width / 25,
              ),
              customTextField(langcontroller, TextInputType.text, 1),
              SizedBox(
                height: width / 25,
              ),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: width / 25,
              ),
              customTextField(descriptioncontroller, TextInputType.text, 5),
              SizedBox(
                height: width / 25,
              ),
              Text(
                'Repository Link',
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: width / 25,
              ),
              customTextField(projectlinkcontroller, TextInputType.text, 1),
              SizedBox(
                height: width / 25,
              ),
              Text(
                'No. of Members',
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: width / 25,
              ),
              customTextField(memberscontroller, TextInputType.number, 1),
              SizedBox(
                height: width / 25,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add project logic here
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color.fromRGBO(111, 39, 152, 1),
                    ),
                  ),
                  child: const Text(
                    'Add Project',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: width / 20),
            ],
          ),
        ),
      ),
    );
  }

  TextField customTextField(
      TextEditingController controller, TextInputType inputType, int line) {
    return TextField(
      controller: controller,
      maxLines: line,
      cursorColor: Colors.white,
      keyboardType: inputType,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(111, 39, 152, 0.8),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
    );
  }

  Future<void> projectImageGetter() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    try {
      final FirebaseStorage _storage = FirebaseStorage.instance;
      final ref = _storage
          .ref()
          .child('projectImages')
          .child('${user!.uid}_project_image.jpg');

      final imageBytes = await image.readAsBytes();
      await ref.putData(imageBytes);

      String downloadUrl = await ref.getDownloadURL();

      setState(() {
        pickedImage = imageBytes;
      });

      print("\n--$downloadUrl--\n");

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      await _firestore.collection("users").doc(user!.uid).set(
          {"profile_image": downloadUrl.toString()}, SetOptions(merge: true));

      print("Profile image URL saved to Firestore.");
    } catch (e) {
      print("Failed to upload and save image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }
}
