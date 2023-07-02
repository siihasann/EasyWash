import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Laundry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BookingForm(),
      ),
    );
  }
}

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _dateTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _dateTimeController,
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            ).then((selectedDate) {
              if (selectedDate != null) {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((selectedTime) {
                  if (selectedTime != null) {
                    DateTime combinedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    _dateTimeController.text = combinedDateTime.toString();
                  }
                });
              }
            });
          },
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Waktu Tanggal',
            hintText: 'Pilih waktu dan tanggal',
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Deskripsi',
            hintText: 'Masukkan deskripsi laundry',
            prefixIcon: Icon(Icons.description),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            String dateTime = _dateTimeController.text;
            String description = _descriptionController.text;

            // Lakukan logika untuk menyimpan data atau mengirim formulir ke server

            // Cetak nilai waktu tanggal dan deskripsi
            print('Waktu Tanggal: $dateTime');
            print('Deskripsi: $description');
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
