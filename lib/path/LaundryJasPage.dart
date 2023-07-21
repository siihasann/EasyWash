import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bookingjas.dart';

class LaundryJasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry Jas'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images2/iklan.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Laundry Jas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Kami menyediakan layanan laundry jas untuk kebutuhan pakaian formal Anda. Dijamin bersih, rapi, dan siap dipakai.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconCard(
                icon: 'assets/icons/mesinmudah.svg',
                text: 'Pengerjaan\nProfesional',
              ),
              IconCard(
                icon: 'assets/icons/categori3.svg',
                text: 'Penyimpanan\nAman',
              ),
              IconCard(
                icon: 'assets/icons/satisfaction.svg',
                text: 'Kepuasan\nPelanggan',
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingLaundryJasPage()),
              );
            },
            child: Text('Booking'),
          ),
        ],
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final String icon;
  final String text;

  const IconCard({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Color(0xFFFFECDF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(icon),
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class BookingFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'),
      ),
      body: Center(
        child: Text('Booking Form'),
      ),
    );
  }
}
