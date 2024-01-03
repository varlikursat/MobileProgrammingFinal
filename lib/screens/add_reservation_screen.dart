import 'package:flutter/material.dart';
import '../models/reservation.dart';
import '../widgets/add_reservation_form.dart';

class AddReservationScreen extends StatelessWidget {
  final Function(Reservation) onAddReservation;

  AddReservationScreen({required this.onAddReservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reservation'),
      ),
      body: AddReservationForm(onAddReservation: onAddReservation),
    );
  }
}
