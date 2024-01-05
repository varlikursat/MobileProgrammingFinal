import 'package:flutter/material.dart';
import '../models/reservation.dart';
import 'package:intl/intl.dart';

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

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(reservation.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${reservation.owner} - ${reservation.work}'),
                Text('Date: ${DateFormat('yyyy-MM-dd').format(reservation.time)}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete(reservation);
                  },
                ),
                Text('${reservation.time.hour}:${reservation.time.minute}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
