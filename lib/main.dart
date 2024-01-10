import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/add_reservation_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Center System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Set the initial route to the login screen
      routes: {
        '/login': (context) => LoginScreen(), // Add the login screen route
        '/main': (context) => MainScreen(),
        '/add_reservation': (context) => AddReservationScreen(
          onAddReservation: (reservation) {},
        ),
      },
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
