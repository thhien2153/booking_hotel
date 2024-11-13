import 'dart:io';

import 'package:bookinghotel/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _bioTextEditingController =
      TextEditingController();

  final _formkey = GlobalKey<FormState>();

  File? imageFileOfUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.green),
        ),
        title: const Text(
          "LOGIN PAGE",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(color: Colors.green),
        child: ListView(
          children: [
            Image.asset(
              "images/signup.png",
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "SIGN UP PAGE",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Email"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _emailTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _passwordTextEditingController,
                        obscureText: true,
                        validator: (valuePassword) {
                          if (valuePassword!.length < 5) {
                            return "Password too weak";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "First Name"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _firstNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your First Name!";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Last Name"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _lastNameTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your Last Name!";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "City"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _cityTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your City name!";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Country"),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        controller: _countryTextEditingController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter your Country Name!";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Bio"),
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        maxLines: 5,
                        controller: _bioTextEditingController,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () async {
                  var imageFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (imageFile != null) {
                    imageFileOfUser = File(imageFile.path);
                    setState(() {
                      imageFileOfUser;
                    });
                  }
                },
                child: imageFileOfUser == null
                    ? const Icon(Icons.add_a_photo_outlined)
                    : CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 5.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          backgroundImage: FileImage(imageFileOfUser!),
                          radius: MediaQuery.of(context).size.width / 5.0,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (!_formkey.currentState!.validate() ||
                      imageFileOfUser == null) {
                    Get.snackbar("Field Missing",
                        "Please choose image and fill out complete sign up form.");
                    return;
                  }
                  if (_emailTextEditingController.text.isEmpty &&
                      _passwordTextEditingController.text.isEmpty) {
                    Get.snackbar("Field Missing",
                        "Please fill out complete sign up form.");
                    return;
                  }
                  userViewModel.signUp(
                    _emailTextEditingController.text.trim(),
                    _passwordTextEditingController.text.trim(),
                    _firstNameTextEditingController.text.trim(),
                    _lastNameTextEditingController.text.trim(),
                    _cityTextEditingController.text.trim(),
                    _countryTextEditingController.text.trim(),
                    _bioTextEditingController.text.trim(),
                    imageFileOfUser,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                ),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
