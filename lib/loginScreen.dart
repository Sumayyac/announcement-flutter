import 'package:announcement/api/loginapi.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Define controllers for the username and password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create a form key to manage the form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(233, 56, 3, 1),
        title: Text('AnnouceEase'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/images.jpg'), // Add your announcement-related background image here
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Add the form key here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Username TextField with transparent background
                  TextFormField(
                    controller: _usernameController, // Set the controller here
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white), // White label text for visibility
                      filled: true,
                      fillColor: Colors.transparent, // Make the background transparent
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null; // Valid input
                    },
                  ),
                  SizedBox(height: 10),

                  // Password TextField with transparent background
                  TextFormField(
                    controller: _passwordController, // Set the controller here
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white), // White label text for visibility
                      filled: true,
                      fillColor: Colors.transparent, // Make the background transparent
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null; // Valid input
                    },
                  ),
                  SizedBox(height: 10),

                  // Login Button
                  Container(
                    width: 100,
                    child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 20, 185, 25),
    foregroundColor: Colors.black,
  ),
  onPressed: () async {
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, proceed with the login logic
      String username = _usernameController.text;  // Get the text from the controller
      String password = _passwordController.text;  // Get the text from the controller

      // Add your login logic here
      print('Username: $username');
      print('Password: $password');

      // Pass the text values (strings) to the loginapi function
      await loginapi(username, password, context);
    }
  },
  child: Text('Login'),
),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
