import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/reservation.dart';
import '../widgets/reservation_list.dart';
import '../widgets/add_reservation_form.dart';

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
    // Fetch reservations when the MainScreen is created
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    // Replace this with your actual data fetching logic
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
        title: Text('Beauty Center System'),
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
          // Handle tab selection
          setState(() {
            _selectedIndex = index;
            // Update the PageView when tapping on the BottomNavigationBar
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
          // Use await to get the result when the AddReservationScreen is popped
          final result = await Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddReservationForm(
              onAddReservation: onAddReservation,
            ),
          ));
          if (result == true) {
            fetchReservations();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        // Update the BottomNavigationBar's selected index when swiping between pages
        setState(() {
          _selectedIndex = index;
        });
      },
      children: [
        // Reservations Tab
        reservations.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ReservationList(reservations: reservations, onDelete: onDeleteReservation),

        // Calendar Tab
        _buildCalendarView(),
      ],
    );
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

          return ListTile(
            title: Text(reservation.name),
            subtitle: Text('${reservation.owner} - ${reservation.work}'),
            trailing: Text('${reservation.time.hour}:${reservation.time.minute}'),
          );
        },
      ),
    );
  }
}
