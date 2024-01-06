import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reservation.dart';

class AddReservationForm extends StatefulWidget {
  final Function(Reservation) onAddReservation;

  AddReservationForm({required this.onAddReservation});

  @override
  _AddReservationFormState createState() => _AddReservationFormState();
}

class _AddReservationFormState extends State<AddReservationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  DateTime selectedTime = DateTime.now(); // Initialize with current date and time
  final TextEditingController workController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Reservation Name'),
          ),
          TextField(
            controller: ownerController,
            decoration: InputDecoration(labelText: 'Reservation Owner'),
          ),
          ListTile(
            title: Text('Reservation Time'),
            subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(selectedTime)),
            onTap: () async {
              DateTime? pickedTime = await showDatePicker(
                context: context,
                initialDate: selectedTime,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (pickedTime != null) {
                TimeOfDay? pickedHour = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedTime),
                );
                if (pickedHour != null) {
                  setState(() {
                    selectedTime = DateTime(
                      pickedTime.year,
                      pickedTime.month,
                      pickedTime.day,
                      pickedHour.hour,
                      pickedHour.minute,
                    );
                  });
                }
              }
            },
          ),
          TextField(
            controller: workController,
            decoration: InputDecoration(labelText: 'Work About Reservation'),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the add reservation screen without adding a reservation
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final owner = ownerController.text;
                  final work = workController.text;

                  // Validate that all fields are filled
                  if (name.isEmpty || owner.isEmpty || work.isEmpty) {
                    // Show an error message or handle it as needed
                    // For simplicity, this example shows a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields.'),
                      ),
                    );
                  } else {
                    final newReservation = Reservation(name: name, owner: owner, time: selectedTime, work: work);
                    widget.onAddReservation(newReservation);

                    Navigator.pop(context); // Close the add reservation screen
                  }
                },
                child: Text('Add Reservation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

