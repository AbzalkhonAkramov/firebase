import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group415/core/route/route_names.dart';
import 'package:group415/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    User? user = await AuthService.signInUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (user != null) {
      Navigator.pushNamed(context, RouteNames.homePage);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Something wrong'),

        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign IN "),
        centerTitle: true,
        backgroundColor: Colors.green,
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
            isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: Text("Sign IN"),
                ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.signUpPage);
              },
              child: Text("Sign UP"),
            ),
          ],
        ),
      ),
    );
  }
}
