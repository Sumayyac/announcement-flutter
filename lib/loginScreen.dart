import 'package:announcement/api/loginapi.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Define controllers for the username and password
  final TextEditingController _usernameController = TextEditingController(text: 'akshay123');
  final TextEditingController _passwordController = TextEditingController(text: '123');

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
        foregroundColor: const Color.fromARGB(255, 250, 248, 248),
        backgroundColor: const Color.fromARGB(255, 57, 57, 59),
        title:  Text('AnnounceEase'),
        
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade100, Colors.brown.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
                      labelStyle: TextStyle(color: const Color.fromARGB(255, 15, 14, 14)), // White label text for visibility
                      filled: true,
                      fillColor: Colors.transparent, // Make the background transparent
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 9, 9, 9)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 7, 7, 7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 10, 10, 10)),
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
                      labelStyle: TextStyle(color: const Color.fromARGB(255, 12, 12, 12)), // White label text for visibility
                      filled: true,
                      fillColor: Colors.transparent, // Make the background transparent
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 9, 9, 9)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 10, 10, 10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: const Color.fromARGB(255, 7, 7, 7)),
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
                  SizedBox(height: 30,),
                  SizedBox(
                   
                    width: 100, 
                    child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 3, 135, 29),
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
