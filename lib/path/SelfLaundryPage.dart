// import 'package:flutter/material.dart';
// import 'FormPage.dart';

// class SelfLaundryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Self Laundry'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/self_laundry_banner.png',
//             width: 200,
//             height: 200,
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Informasi mengenai self laundry',
//             style: TextStyle(fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FormPage()),
//               );
//             },
//             child: Text('Booking Now'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'FormPage.dart';

class SelfLaundryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Laundry'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images2/Self Laundry.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Selamat Datang di Self Laundry!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Kami menyediakan fasilitas self laundry yang memungkinkan Anda untuk mencuci pakaian sendiri dengan mudah. Tersedia mesin cuci dan pengering modern serta ruang nyaman untuk melipat pakaian.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureCard(
                  icon: 'assets/icons/washing_machine.svg',
                  title: 'Mesin Cuci\nModern',
                  description:
                      'Nikmati fasilitas mesin cuci terbaru yang mampu mencuci pakaian dengan bersih dan efisien.',
                ),
                FeatureCard(
                  icon: 'assets/icons/dryer.svg',
                  title: 'Pengering\nEfisien',
                  description:
                      'Pengering kami menggunakan teknologi canggih sehingga pakaian Anda cepat kering tanpa merusak kain.',
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeatureCard(
                  icon: 'assets/icons/convenient.svg',
                  title: 'Mudah\nDigunakan',
                  description:
                      'Kami menyediakan panduan penggunaan yang jelas sehingga Anda dapat dengan mudah menggunakan fasilitas self laundry kami.',
                ),
                FeatureCard(
                  icon: 'assets/icons/folding_clothes.svg',
                  title: 'Ruang Lipat\nNyaman',
                  description:
                      'Setelah mencuci dan mengeringkan pakaian, Anda dapat menggunakan ruang lipat yang nyaman untuk melipat pakaian dengan rapi.',
                ),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
              },
              child: Text('Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon, height: 80),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
