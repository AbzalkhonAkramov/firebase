import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group415/core/route/route_names.dart';
import 'package:group415/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> signUp() async {
    if (passwordController.text.trim() ==
        repeatPasswordController.text.trim()) {
      setState(() {
        isLoading = true;
      });
      User? user = await AuthService.signUpUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (user != null) {
        Navigator.pushNamed(context, RouteNames.homePage);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: const Text('Something wrong')));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign UP "),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: repeatPasswordController,
              decoration: InputDecoration(labelText: "Repeat password"),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text("Sign UP"),
                ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.signInPage);
              },
              child: Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
