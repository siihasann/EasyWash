// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../size_config.dart';

// class Categories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/icons/self_laundry.svg", "text": "Self Laundry"},
//       {"icon": "assets/icons/kiloan_kilat.svg", "text": "Kiloan Kilat"},
//       {"icon": "assets/icons/kiloan_kilat.svg", "text": "Laundry Jas"},
//       {"icon": "assets/icons/kiloan_kilat.svg", "text": "Laundry Boneka"},
//       {"icon": "assets/icons/Discover.svg", "text": "More"},
//     ];
//     return Padding(
//       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(
//           categories.length,
//           (index) => CategoryCard(
//             icon: categories[index]["icon"],
//             text: categories[index]["text"],
//             press: () {},
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String? icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getProportionateScreenWidth(55),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(15)),
//               height: getProportionateScreenWidth(55),
//               width: getProportionateScreenWidth(55),
//               decoration: BoxDecoration(
//                 color: Color(0xFFFFECDF),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: SvgPicture.asset(icon!),
//             ),
//             SizedBox(height: 5),
//             Text(text!, textAlign: TextAlign.center)
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import '/path/bookingself.dart';
import '/path/bookingjas.dart';
import '/path/bookingboneka.dart';
import '/path/bookingkiloan.dart';
import '/path/SelfLaundryPage.dart';
import '/path/KiloanKilatPage.dart';
import '/path/LaundryJasPage.dart';
import '/path/LaundryBonekaPage.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/categori1.svg", "text": "Self Laundry"},
      {"icon": "assets/icons/categori2.svg", "text": "Kiloan Kilat"},
      {"icon": "assets/icons/categori3.svg", "text": "Laundry Jas"},
      {"icon": "assets/icons/categori4.svg", "text": "Laundry Boneka"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            onPressed: () =>
                _navigateToCategoryPage(context, categories[index]["text"]),
          ),
        ),
      ),
    );
  }

  void _navigateToCategoryPage(BuildContext context, String categoryName) {
    if (categoryName == "Self Laundry") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelfLaundryPage()),
      );
    } else if (categoryName == "Kiloan Kilat") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KiloanKilatPage()),
      );
    } else if (categoryName == "Laundry Jas") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LaundryJasPage()),
      );
    } else if (categoryName == "Laundry Boneka") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LaundryBonekaPage()),
      );
    } else {
      // Jika Anda memiliki halaman lain untuk kategori yang berbeda, tambahkan perutean di sini.
    }
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String? icon, text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
