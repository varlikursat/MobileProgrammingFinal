import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/reservation.dart';
import '../widgets/reservation_list.dart';
import '../widgets/add_reservation_form.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Reservation> reservations = [];
  DateTime selectedDay = DateTime.now();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      reservations = [
        Reservation(name: 'Reservation 1', owner: 'Kursat Varli', time: DateTime.now(), work: 'Haircut'),
        Reservation(name: 'Reservation 2', owner: 'John Doe', time: DateTime.now().add(Duration(days: 1)), work: 'Manicure'),
        Reservation(name: 'Reservation 3', owner: 'Jane Doe', time: DateTime.now().add(Duration(days: 2)), work: 'Massage'),
        Reservation(name: 'Reservation 4', owner: 'Alice Smith', time: DateTime.now().add(Duration(days: 3)), work: 'Facial'),
      ];
    });
  }

  void onAddReservation(Reservation newReservation) {
    setState(() {
      reservations.add(newReservation);
    });
  }

  void onDeleteReservation(Reservation reservation) {
    setState(() {
      reservations.remove(reservation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Beauty Center System'),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Reservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        currentIndex: _selectedIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddReservationForm(
              onAddReservation: onAddReservation,
            ),
          ));
          if (result == true) {
            fetchReservations();
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      children: [
        reservations.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ReservationList(reservations: reservations, onDelete: onDeleteReservation),
        _buildCalendarView(),
      ],
    );
  }

  List<dynamic> _dateHasReservations(DateTime date) {
    return reservations.where((reservation) =>
        reservation.time.year == date.year &&
        reservation.time.month == date.month &&
        reservation.time.day == date.day).toList();
  }

  Widget _buildCalendarView() {
  return Column(
    children: [
      TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2024, 1, 30),
        focusedDay: selectedDay,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
          });
        },
      ),
      SizedBox(height: 16),
      _buildReservationsForDate(selectedDay),
    ],
  );
}
 

  Widget _buildReservationsForDate(DateTime date) {
    final filteredReservations = reservations.where((reservation) {
      return reservation.time.year == date.year &&
          reservation.time.month == date.month &&
          reservation.time.day == date.day;
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredReservations.length,
        itemBuilder: (context, index) {
          final reservation = filteredReservations[index];

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
                      onDeleteReservation(reservation);
                    },
                  ),
                  Text('${reservation.time.hour}:${reservation.time.minute}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}