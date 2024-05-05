import 'package:calendar/constants/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  // ignore: unused_field
  late DateTime _selectedYear;
  late DateTime _currentTime;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _selectedYear = DateTime.now();
    _currentTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(_buildAppBarTitle()),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Ritzz',
              style: TextStyle(fontWeight: FontWeight.w900, color: GlobalVariables.mainColor),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 50),
            height: height * 0.50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    getSeasonImage(_selectedDay.month),
                    height: 150,
                    width: 150,
                  ),
                ),
                TableCalendar(
                  firstDay: DateTime.utc(1970),
                  lastDay: DateTime.utc(2030),
                  focusedDay: _focusedDay,
                  pageAnimationEnabled: true,
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: GlobalVariables.tealColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                    weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    print(selectedDay);
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper alignment
            children: [
              Container(
                width: 50,
                margin: const EdgeInsets.only(left: 30),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_selectedDay.day}',
                        style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold), // Print current date
                      ),
                      Text(
                        // _getMonthName(_selectedDay.month),
                        _getWeekdayName(_selectedDay.weekday),
                        style: const TextStyle(color: GlobalVariables.darkGrey, fontSize: 13),
                      ),
                      // Text('${Provider.of<eventProvider>(context).event.totalDays}')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalVariables.mainColor,
        shape: CircleBorder(),
        onPressed: () {}, // Call function to add event
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  String _buildAppBarTitle() {
    int currentHour = _currentTime.hour;

    // Determine the greeting based on the current hour
    String greeting = '';
    if (currentHour < 12) {
      greeting = 'Morning';
    } else if (currentHour < 17) {
      greeting = 'Afternoon';
    } else {
      greeting = 'Evening';
    }

    return 'Good $greeting';
  }
}

String getSeasonImage(int month) {
  // Determine season based on the month
  if (month >= 3 && month <= 5) {
    return "Asset/summer.jpg";
  } else if (month >= 6 && month <= 8) {
    return "Asset/monsoon1.jpg";
  } else if (month >= 9 && month <= 11) {
    return "Asset/autumn.jpg";
  } else {
    return "Asset/winter.jpg";
  }
}

// String _getMonthName(int month) {
//   // List of month names
//   List<String> months = [
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December'
//   ];

//   // Return the corresponding month name based on the month value
//   return months[month - 1];
// }

// Outside the build method of your HomeScreen widget
String _getWeekdayName(int weekday) {
  // List of weekday names
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  // Return the corresponding weekday name based on the weekday value
  return weekdays[weekday - 1];
}
