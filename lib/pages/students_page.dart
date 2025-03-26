import 'package:flutter/material.dart';
import 'package:group415/models/student.dart';
import 'package:group415/services/rtdb_service.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<String> ids = [];
  List<Student> studentsList = [];
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    Map<String, Student>? students = await RTDBService.readData();
    setState(() {
      ids = students!.keys.toList();
      studentsList = students.values.toList();
      isLoading = false;
    });
  }

  Future<void> deleteStudent({required String id}) async {
    await RTDBService.deleteData(id);
    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students page"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (context, index) {
                    Student student = studentsList[index];
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          myBottomSheet(
                            context: context,
                            id: ids[index],
                            student: student,
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      title: Text(
                        student.firstName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        student.lastName,
                        style: TextStyle(fontSize: 17),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          deleteStudent(id: ids[index]);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  void myBottomSheet({
    required BuildContext context,
    required String id,
    required Student student,
  }) {
    TextEditingController firstNameController = TextEditingController(
      text: student.firstName,
    );
    TextEditingController lastNameController = TextEditingController(
      text: student.lastName,
    );
    TextEditingController courseController = TextEditingController(
      text: student.course.toString(),
    );
    TextEditingController facultyController = TextEditingController(
      text: student.faculty,
    );
    TextEditingController imgUrlController = TextEditingController(
      text: student.imageUrl,
    );
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              ElevatedButton(
                onPressed: () async {
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

                  await RTDBService.updateData(student, id);
                  getData();
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
