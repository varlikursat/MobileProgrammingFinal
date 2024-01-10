import 'package:flutter/material.dart';
import '../models/reservation.dart';
import 'package:intl/intl.dart';

class ReservationList extends StatefulWidget {
  final List<Reservation> reservations;
  final Function(Reservation) onDelete;

  ReservationList({required this.reservations, required this.onDelete});

  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  late List<Reservation> filteredReservations;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredReservations = widget.reservations;
  }

  void filterReservations(String query) {
    setState(() {
      filteredReservations = widget.reservations
          .where((reservation) =>
              reservation.name.toLowerCase().contains(query.toLowerCase()) ||
              reservation.owner.toLowerCase().contains(query.toLowerCase()) ||
              reservation.work.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: filterReservations,
            decoration: InputDecoration(
              labelText: 'Search Reservations',
              labelStyle: TextStyle(color: Color.fromARGB(186, 242, 241, 241)),
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: filteredReservations.length,
            itemBuilder: (context, index) {
              final reservation = filteredReservations[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromARGB(255, 29, 9, 48).withOpacity(0.5), // Change the background color of the Card
                  ),
                  child: ListTile(
                    title: Text(
                      reservation.name,
                      style: TextStyle(color: Colors.white), // Change text color
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${reservation.owner} - ${reservation.work}',
                          style: TextStyle(color: Colors.white), // Change text color
                        ),
                        Text(
                          'Date: ${DateFormat('yyyy-MM-dd').format(reservation.time)}',
                          style: TextStyle(color: Colors.white), // Change text color
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${reservation.time.hour}:${reservation.time.minute}   ',
                          style: TextStyle(color: Colors.white), // Change text color
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.white,),
                          onPressed: () {
                            widget.onDelete(reservation);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
            },
          ),
        ),
      ],
    );
  }
}
