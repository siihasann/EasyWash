// import 'package:flutter/material.dart';

// import '../../../size_config.dart';

// class DiscountBanner extends StatelessWidget {
//   const DiscountBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 90,
//       width: double.infinity,
//       margin: EdgeInsets.all(getProportionateScreenWidth(20)),
//       padding: EdgeInsets.symmetric(
//         horizontal: getProportionateScreenWidth(20),
//         vertical: getProportionateScreenWidth(15),
//       ),
//       decoration: BoxDecoration(
//         color: Color(0xFF4A3298),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text.rich(
//         TextSpan(
//           style: TextStyle(color: Colors.white),
//           children: [
//             TextSpan(text: "A Summer Surpise\n"),
//             TextSpan(
//               text: "Cashback 20%",
//               style: TextStyle(
//                 fontSize: getProportionateScreenWidth(24),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

import '../../../size_config.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final sharedPreferences = snapshot.data!;
        final firstName = sharedPreferences.getString('firstName');
        final lastName = sharedPreferences.getString('lastName');
        final email = sharedPreferences.getString('email');
        final address = sharedPreferences.getString('address');
        final phoneNumber = sharedPreferences.getString('phoneNumber');
        final profileImage =
            'assets/images2/profil.png'; // Path to your profile image

        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(getProportionateScreenWidth(20)),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(15),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF4A3298),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            // You can also use gradients or other decorations here
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: getProportionateScreenWidth(30),
                backgroundImage: AssetImage(profileImage),
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ), // Add an edit icon here or use a different one
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      'Name: $firstName $lastName',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
