import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 3, 42, 108), Color.fromARGB(255, 208, 85, 64)],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Beauty Center",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -10,
              top: 130,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 226, 150, 26).withOpacity(0.2),
              ),
            ),
            Positioned(
              right: -30,
              bottom: 60,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromARGB(255, 32, 32, 203).withOpacity(0.2),
              ),
            ),
            Positioned(
              right: -30,
              top: 90,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Color.fromARGB(255, 227, 65, 15).withOpacity(0.2),
              ),
            ),
            Center(
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showInvalidCredentials = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 170),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 15, 5, 78).withOpacity(0.35), // Set semi-transparent white color for glassmorphism
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Text("LOG IN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal
                ),),
          SizedBox(height:40),
          TextField(
            controller: emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: const Color.fromARGB(255, 192, 192, 192)),
              prefixIcon: Icon(Icons.email, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: const Color.fromARGB(255, 192, 192, 192)),
              prefixIcon: Icon(Icons.lock, color: Colors.white),
            ),
            obscureText: true,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              final String email = emailController.text;
              final String password = passwordController.text;

              if (email.isNotEmpty && password.isNotEmpty) {
                Navigator.pushReplacementNamed(context, '/main');
              } else {
                setState(() {
                  showInvalidCredentials = true;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text('Login'),
          ),
          if (showInvalidCredentials)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Invalid credentials. Please try again.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}