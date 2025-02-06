import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({required this.userData, super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController departmentController;
  late TextEditingController qualificationController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    departmentController = TextEditingController(text: widget.userData['department']);
    qualificationController = TextEditingController(text: widget.userData['qualification']);
    phoneController = TextEditingController(text: widget.userData['phone']);
    emailController = TextEditingController(text: widget.userData['email']);
  }

  @override
  void dispose() {
    nameController.dispose();
    departmentController.dispose();
    qualificationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name', nameController),
            _buildTextField('Department', departmentController),
            _buildTextField('Qualification', qualificationController),
            _buildTextField('Phone', phoneController),
            _buildTextField('Email', emailController),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> updatedData = {
                    'name': nameController.text,
                    'department': departmentController.text,
                    'qualification': qualificationController.text,
                    'phone': phoneController.text,
                    'email': emailController.text,
                  };
                  Navigator.pop(context, updatedData);
                },
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}