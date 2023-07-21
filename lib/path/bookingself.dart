// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class FormPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking Laundry'),
//       ),
//       body: Padding(

//         padding: EdgeInsets.all(16.0),
//         child: BookingForm(),
//       ),
//     );
//   }
// }

// class BookingForm extends StatefulWidget {
//   @override
//   _BookingFormState createState() => _BookingFormState();
// }

// class _BookingFormState extends State<BookingForm> {
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   TextEditingController _descriptionController = TextEditingController();
//   String _errorMessage = '';

//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   bool isSlotAvailable(DateTime dateTime) {
//     // Lakukan logika untuk memeriksa ketersediaan slot jadwal
//     // Mengembalikan true jika slot tersedia, false jika slot sudah terisi
//     return true;
//   }

//   Future<void> selectDate() async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );

//     if (selectedDate != null) {
//       setState(() {
//         _selectedDate = selectedDate;
//       });
//     }
//   }

//   Future<void> selectTime() async {
//     final TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (selectedTime != null) {
//       setState(() {
//         _selectedTime = selectedTime;
//       });
//     }
//   }

//   void submitForm() {
//     String description = _descriptionController.text;

//     if (_selectedDate == null || _selectedTime == null || description.isEmpty) {
//       setState(() {
//         _errorMessage = 'Form tidak boleh kosong';
//       });
//       return;
//     }

//     DateTime selectedDateTime = DateTime(
//       _selectedDate!.year,
//       _selectedDate!.month,
//       _selectedDate!.day,
//       _selectedTime!.hour,
//       _selectedTime!.minute,
//     );

//     if (!isSlotAvailable(selectedDateTime)) {
//       setState(() {
//         _errorMessage = 'Slot jadwal sudah terisi. Silakan pilih jam lain.';
//       });
//       return;
//     }

//     // Lakukan logika untuk menyimpan data atau mengirim formulir ke server

//     // Reset form setelah berhasil submit
//     _descriptionController.clear();
//     setState(() {
//       _selectedDate = null;
//       _selectedTime = null;
//       _errorMessage = '';
//     });

//     // Tampilkan notifikasi atau tindakan lain setelah submit berhasil
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Form berhasil disubmit')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: selectDate,
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 16.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.calendar_today),
//                 SizedBox(width: 8.0),
//                 Text(
//                   _selectedDate == null
//                       ? 'Pilih Tanggal'
//                       : DateFormat('dd MMMM yyyy').format(_selectedDate!),
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 16.0),
//         GestureDetector(
//           onTap: selectTime,
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 16.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.access_time),
//                 SizedBox(width: 8.0),
//                 Text(
//                   _selectedTime == null
//                       ? 'Pilih Jam'
//                       : _selectedTime!.format(context),
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 16.0),
//         TextFormField(
//           controller: _descriptionController,
//           decoration: InputDecoration(
//             labelText: 'Deskripsi',
//             hintText: 'Masukkan deskripsi laundry',
//             prefixIcon: Icon(Icons.description),
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 16.0),
//         ElevatedButton(
//           onPressed: submitForm,
//           child: Text('Submit'),
//         ),
//         SizedBox(height: 8.0),
//         Text(
//           _errorMessage,
//           style: TextStyle(color: Colors.red),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Self Laundry'),
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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  String? _selectedCategory;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  bool isSlotAvailable(DateTime dateTime) {
    // Lakukan logika untuk memeriksa ketersediaan slot jadwal
    // Mengembalikan true jika slot tersedia, false jika slot sudah terisi
    return true;
  }

  Future<void> selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  void submitForm() {
    String description = _descriptionController.text;
    String weight = _weightController.text;

    if (_selectedCategory == null ||
        _selectedDate == null ||
        _selectedTime == null ||
        weight.isEmpty ||
        description.isEmpty) {
      setState(() {
        _errorMessage = 'Form tidak boleh kosong';
      });
      return;
    }

    DateTime selectedDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (!isSlotAvailable(selectedDateTime)) {
      setState(() {
        _errorMessage = 'Slot jadwal sudah terisi. Silakan pilih jam lain.';
      });
      return;
    }

    // Lakukan logika untuk menyimpan data atau mengirim formulir ke server
    Map<String, dynamic> formData = {
      'category': _selectedCategory!,
      'selectedDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'selectedTime': _selectedTime!.format(context),
      'weight': weight,
      'description': description,
    };

    // Reset form setelah berhasil submit
    _descriptionController.clear();
    _weightController.clear();
    setState(() {
      _selectedCategory = null;
      _selectedDate = null;
      _selectedTime = null;
      _errorMessage = '';
    });

    // Tampilkan notifikasi atau tindakan lain setelah submit berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form berhasil disubmit')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            labelText: 'Kategori',
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(
              value: 'dry_clean',
              child: Text('Dry Clean'),
            ),
            DropdownMenuItem(
              value: 'cuci',
              child: Text('Cuci'),
            ),
            DropdownMenuItem(
              value: 'cuci_dan_dry_clean',
              child: Text('Cuci dan Dry Clean'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: selectDate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8.0),
                Text(
                  _selectedDate == null
                      ? 'Pilih Tanggal'
                      : DateFormat('dd MMMM yyyy').format(_selectedDate!),
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        GestureDetector(
          onTap: selectTime,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 8.0),
                Text(
                  _selectedTime == null
                      ? 'Pilih Jam'
                      : _selectedTime!.format(context),
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          controller: _weightController,
          decoration: InputDecoration(
            labelText: 'Estimasi Berat (Kg)',
            hintText: 'Masukkan estimasi berat laundry dalam Kg',
            prefixIcon: Icon(Icons.line_weight),
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
          onPressed: submitForm,
          child: Text('Submit'),
        ),
        SizedBox(height: 8.0),
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
