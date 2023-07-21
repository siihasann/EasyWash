import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bookingkiloan.dart';

class KiloanKilatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiloan Kilat'),
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
            'Kiloan Kilat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Kami menyediakan layanan kiloan kilat untuk kebutuhan laundry Anda. Cepat, praktis, dan terpercaya.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconCard(
                icon: 'assets/icons/categori1.svg',
                text: 'Mesin Cuci\nModern',
              ),
              IconCard(
                icon: 'assets/icons/delivery.svg',
                text: 'Pengantaran\nKilat',
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
                    builder: (context) => BookingLaundryKiloanPage()),
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
