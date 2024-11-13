import 'package:bookinghotel/global.dart';
import 'package:bookinghotel/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.green),
        child: ListView(
          children: [
            Image.asset(
              "images/login.png",
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "LOGIN PAGE",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Email"),
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      controller: _emailTextEditingController,
                      validator: (valueEmail) {
                        if (valueEmail == null || valueEmail.isEmpty) {
                          return "Please enter your Email";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Password"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await userViewModel.login(
                              _emailTextEditingController.text.trim(),
                              _passwordTextEditingController.text.trim());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: const Text(
                        "Don't have an acount? Create here",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
