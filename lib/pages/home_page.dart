import 'package:flutter/material.dart';
import 'package:group415/core/route/route_names.dart';
import 'package:group415/models/student.dart';
import 'package:group415/services/auth_service.dart';
import 'package:group415/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  bool isLoading = false;

  Future<void> createData() async {
    setState(() {
      isLoading = true;
    });
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    int course = int.parse(courseController.text.trim());
    String faculty = facultyController.text.trim();
    String imageUrl = imgUrlController.text.trim();

    Student student = Student(
      firstName: firstName,
      lastName: lastName,
      course: course,
      faculty: faculty,
      imageUrl: imageUrl,
    );
    if (await RTDBService.createData(student: student) == false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Something wrong')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Successfully created')));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.studentsPage);
            },
            icon: Icon(Icons.arrow_circle_right_outlined),
          ),

          IconButton(
            onPressed: () {
              AuthService.signOutUser();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "First name"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: "Last name"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: courseController,
                decoration: InputDecoration(labelText: "Course"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: facultyController,
                decoration: InputDecoration(labelText: "Faculty"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: imgUrlController,
                decoration: InputDecoration(labelText: "Image url"),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : ElevatedButton(
                    onPressed: () {
                      createData();
                    },
                    child: Text("Create"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
