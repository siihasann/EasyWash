// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class BookingLaundryKiloanPage extends StatefulWidget {
//   @override
//   _BookingLaundryKiloanPageState createState() =>
//       _BookingLaundryKiloanPageState();
// }

// class _BookingLaundryKiloanPageState extends State<BookingLaundryKiloanPage> {
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   TextEditingController _weightController = TextEditingController();
//   TextEditingController _descriptionController = TextEditingController();

//   @override
//   void dispose() {
//     _weightController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (pickedTime != null) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   void _submitForm() {
//     String weight = _weightController.text;
//     String description = _descriptionController.text;

//     if (_selectedDate == null ||
//         _selectedTime == null ||
//         weight.isEmpty ||
//         description.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Form Error'),
//             content: Text('Please fill in all fields.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Do something with the form data
//       // ...

//       // Clear form fields
//       _weightController.clear();
//       _descriptionController.clear();

//       // Reset selected date and time
//       setState(() {
//         _selectedDate = null;
//         _selectedTime = null;
//       });

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Form submitted successfully')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking Laundry Kiloan'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Booking Laundry Kiloan',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 24.0),
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text(
//                 _selectedDate == null
//                     ? 'Select Date'
//                     : DateFormat('dd MMMM yyyy').format(_selectedDate!),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text(
//                 _selectedTime == null
//                     ? 'Select Time'
//                     : _selectedTime!.format(context),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: _weightController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Estimated Weight (Kg)',
//                 hintText: 'Enter estimated weight in kilograms',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: _descriptionController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 hintText: 'Enter description',
//               ),
//             ),
//             SizedBox(height: 24.0),
//             ElevatedButton(
//               onPressed: _submitForm,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     title: 'Booking Laundry Kiloan',
//     home: BookingLaundryKiloanPage(),
//   ));
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return '$date,$time,$weight,$description';
  }

  static BookingData fromString(String bookingString) {
    List<String> bookingData = bookingString.split(',');

    DateTime date = DateTime.parse(bookingData[0]);
    TimeOfDay time = TimeOfDay.fromDateTime(DateTime.parse(bookingData[1]));
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

  Future<List<BookingData>> _loadBookingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> bookings = prefs.getStringList('bookingList') ?? [];

    List<BookingData> loadedBookings = [];
    for (String bookingString in bookings) {
      loadedBookings.add(BookingData.fromString(bookingString));
    }

    setState(() {
      _bookingList = loadedBookings;
    });

    return loadedBookings;
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
            SizedBox(height: 24.0),
            Text(
              'Booking History',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _bookingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'Date: ${DateFormat('dd MMMM yyyy').format(_bookingList[index].date)}'),
                  subtitle: Text(
                      'Time: ${_bookingList[index].time.format(context)}\nWeight: ${_bookingList[index].weight}\nDescription: ${_bookingList[index].description}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Booking Laundry Kiloan',
    home: BookingLaundryKiloanPage(),
  ));
}
