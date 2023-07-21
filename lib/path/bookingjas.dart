import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingLaundryJasPage extends StatefulWidget {
  @override
  _BookingLaundryJasPageState createState() => _BookingLaundryJasPageState();
}

class _BookingLaundryJasPageState extends State<BookingLaundryJasPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
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

  void _submitForm() {
    String description = _descriptionController.text;

    if (_selectedDate == null || _selectedTime == null || description.isEmpty) {
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
      // Do something with the form data
      // ...

      // Clear form fields
      _descriptionController.clear();

      // Reset selected date and time
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Laundry Jas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Booking Laundry Jas',
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

void main() {
  runApp(MaterialApp(
    title: 'Booking Laundry App',
    home: BookingLaundryJasPage(),
  ));
}
