import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingFormPage extends StatefulWidget {
  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  String _selectedCategory = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitForm() async {
    // Simpan data booking sementara
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookingCategory', _selectedCategory);
    await prefs.setString(
        'bookingDate', DateFormat('yyyy-MM-dd').format(_selectedDate));
    await prefs.setString('bookingTime', _selectedTime.format(context));
    await prefs.setString('bookingDescription', _descriptionController.text);

    // Reset form setelah berhasil submit
    setState(() {
      _selectedCategory = '';
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
      _descriptionController.clear();
    });

    // Tampilkan notifikasi atau tindakan lain setelah submit berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form berhasil disubmit')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Self Laundry'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Kategori Layanan',
              ),
              items: [
                DropdownMenuItem<String>(
                  value: 'Cuci',
                  child: Text('Cuci'),
                ),
                DropdownMenuItem<String>(
                  value: 'Dry Clean',
                  child: Text('Dry Clean'),
                ),
                DropdownMenuItem<String>(
                  value: 'Cuci dan Dry Clean',
                  child: Text('Cuci dan Dry Clean'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.calendar_today),
                    Text(
                      DateFormat('dd MMMM yyyy').format(_selectedDate),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (pickedTime != null) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.access_time),
                    Text(
                      _selectedTime.format(context),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(height: 16.0),
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
