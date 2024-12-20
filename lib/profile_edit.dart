import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  // Example data for the profile
  final String name = "John Doe";
  final String department = "Software Engineering";
  final String qualification = "B.Sc. in Computer Science";
  final String phone = "+1 234 567 890";
  final String email = "john.doe@example.com";
  final String semester = "4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://www.example.com/profile_picture.jpg', // Replace with a valid image URL
                ),
              ),
            ),
            SizedBox(height: 16),

            // Name
            Text(
              "Name: $name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            // Department
            Text(
              "Department: $department",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            // Qualification
            Text(
              "Qualification: $qualification",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            // Phone
            Text(
              "Phone: $phone",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),

            // Email
            Text(
              "Email: $email",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 32),
          Text(
              "semester: $semester",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 32),
            // Button to Edit Profile (optional)
           
          ],
        ),
      ),
    );
  }
}
