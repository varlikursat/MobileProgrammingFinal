import 'package:flutter/material.dart';
import '../models/reservation.dart';

class ReservationList extends StatelessWidget {
  final List<Reservation> reservations;
  final Function(Reservation) onDelete;

  ReservationList({required this.reservations, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];

        return ListTile(
          title: Text(reservation.name),
          subtitle: Text('${reservation.owner} - ${reservation.work}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Trigger the onDelete callback with the entire reservation object
                  onDelete(reservation);
                },
              ),
              Text('${reservation.time.hour}:${reservation.time.minute}'),
            ],
          ),
        );
      },
    );
  }
}
