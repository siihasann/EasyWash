// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'bookingkiloan.dart';

// class BookingData {
//   final DateTime date;
//   final TimeOfDay time;
//   final String weight;
//   final String description;

//   BookingData({
//     required this.date,
//     required this.time,
//     required this.weight,
//     required this.description,
//   });

//   @override
//   String toString() {
//     return '${DateFormat('yyyy-MM-dd').format(date)},${time.hour}:${time.minute},$weight,$description';
//   }

//   static BookingData fromString(String bookingString) {
//     List<String> bookingData = bookingString.split(',');

//     DateTime date = DateFormat('yyyy-MM-dd').parse(bookingData[0]);
//     TimeOfDay time = TimeOfDay(
//       hour: int.parse(bookingData[1].split(':')[0]),
//       minute: int.parse(bookingData[1].split(':')[1]),
//     );
//     String weight = bookingData[2];
//     String description = bookingData[3];

//     return BookingData(
//       date: date,
//       time: time,
//       weight: weight,
//       description: description,
//     );
//   }
// }

// class HistoryBookingPage extends StatelessWidget {
//   Future<List<BookingData>> _loadBookingData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<String> bookings = prefs.getStringList('bookingList') ?? [];

//     List<BookingData> loadedBookings = [];
//     for (String bookingString in bookings) {
//       loadedBookings.add(BookingData.fromString(bookingString));
//     }

//     return loadedBookings;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('History Booking'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<BookingData>>(
//         future: _loadBookingData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<BookingData> bookings = snapshot.data!;

//             if (bookings.isEmpty) {
//               return Center(
//                 child: Text('No Booking History'),
//               );
//             }

//             return ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     'Date: ${DateFormat('dd MMMM yyyy').format(bookings[index].date)}',
//                   ),
//                   subtitle: Text(
//                     'Time: ${bookings[index].time.format(context)}\nWeight: ${bookings[index].weight}\nDescription: ${bookings[index].description}',
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Booking App',
//     initialRoute: '/',
//     routes: {
//       '/': (context) => BookingLaundryKiloanPage(),
//       '/history': (context) => HistoryBookingPage(),
//     },
//   ));
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookingkiloan.dart';

class BookingData {
  final DateTime date;
  final TimeOfDay time;
  final String weight;
  final String description;

  BookingData({
    required this.date,
    required this.time,
    required this.weight,
    required this.description,
  });

  @override
  String toString() {
    return '${DateFormat('yyyy-MM-dd').format(date)},,$weight,$description';
  }

  static BookingData fromString(String bookingString) {
    List<String> bookingData = bookingString.split(',');

    DateTime date = DateFormat('yyyy-MM-dd').parse(bookingData[0]);
    TimeOfDay time = TimeOfDay(
      hour: int.parse(bookingData[1].split(':')[0]),
      minute: int.parse(bookingData[1].split(':')[1]),
    );
    String weight = bookingData[2];
    String description = bookingData[3];

    return BookingData(
      date: date,
      time: time,
      weight: weight,
      description: description,
    );
  }
}

class BookingLaundryKiloanPage extends StatefulWidget {
  @override
  _BookingLaundryKiloanPageState createState() =>
      _BookingLaundryKiloanPageState();
}

class _BookingLaundryKiloanPageState extends State<BookingLaundryKiloanPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _weightController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<BookingData> _bookingList = [];

  @override
  void initState() {
    super.initState();
    _loadBookingData();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _saveBookingData(BookingData bookingData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookings = prefs.getStringList('bookingList') ?? [];
    bookings.add(bookingData.toString());
    prefs.setStringList('bookingList', bookings);
  }

  Future<void> _loadBookingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookings = prefs.getStringList('bookingList') ?? [];

    List<BookingData> loadedBookings = [];
    for (String bookingString in bookings) {
      loadedBookings.add(BookingData.fromString(bookingString));
    }

    setState(() {
      _bookingList = loadedBookings;
    });
  }

  void _submitForm() async {
    String weight = _weightController.text;
    String description = _descriptionController.text;

    if (_selectedDate == null ||
        _selectedTime == null ||
        weight.isEmpty ||
        description.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Form Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      BookingData newBooking = BookingData(
        date: _selectedDate!,
        time: _selectedTime!,
        weight: weight,
        description: description,
      );

      await _saveBookingData(newBooking);

      setState(() {
        _bookingList.add(newBooking);
      });

      _weightController.clear();
      _descriptionController.clear();

      setState(() {
        _selectedDate = null;
        _selectedTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Laundry Kiloan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Booking Laundry Kiloan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : DateFormat('dd MMMM yyyy').format(_selectedDate!),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(
                _selectedTime == null
                    ? 'Select Time'
                    : _selectedTime!.format(context),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Estimated Weight (Kg)',
                hintText: 'Enter estimated weight in kilograms',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryBookingPage extends StatefulWidget {
  @override
  _HistoryBookingPageState createState() => _HistoryBookingPageState();
}

class _HistoryBookingPageState extends State<HistoryBookingPage> {
  List<BookingData> _bookingList = [];

  @override
  void initState() {
    super.initState();
    _loadBookingData();
  }

  Future<void> _loadBookingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookings = prefs.getStringList('bookingList') ?? [];

    List<BookingData> loadedBookings = [];
    for (String bookingString in bookings) {
      loadedBookings.add(BookingData.fromString(bookingString));
    }

    setState(() {
      _bookingList = loadedBookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Booking'),
        centerTitle: true,
      ),
      body: _bookingList.isEmpty
          ? Center(
              child: Text('No Booking History'),
            )
          : ListView.builder(
              itemCount: _bookingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Date: ${DateFormat('dd MMMM yyyy').format(_bookingList[index].date)}',
                  ),
                  subtitle: Text(
                    'Time: ${_bookingList[index].time.format(context)}\nWeight: ${_bookingList[index].weight}\nDescription: ${_bookingList[index].description}',
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Booking App',
    initialRoute: '/',
    routes: {
      '/': (context) => BookingLaundryKiloanPage(),
      '/history': (context) => HistoryBookingPage(),
    },
  ));
}
