import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/add_reservation_screen.dart';

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
      home: MainScreen(),
      routes: {
        '/add_reservation': (context) => AddReservationScreen(
              onAddReservation: (reservation) {
              },
            ),
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Beauty Center System'),
          ),
          body: child,
        );
      },
    );
  }
}
