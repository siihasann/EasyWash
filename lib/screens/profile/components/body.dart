// import 'package:flutter/material.dart';

// import 'profile_menu.dart';
// import 'profile_pic.dart';

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: [
//           ProfilePic(),
//           SizedBox(height: 20),
//           ProfileMenu(
//             text: "My Account",
//             icon: "assets/icons/User Icon.svg",
//             press: () => {},
//           ),
//           ProfileMenu(
//             text: "Notifications",
//             icon: "assets/icons/Bell.svg",
//             press: () {},
//           ),
//           ProfileMenu(
//             text: "Settings",
//             icon: "assets/icons/Settings.svg",
//             press: () {},
//           ),
//           ProfileMenu(
//             text: "Help Center",
//             icon: "assets/icons/Question mark.svg",
//             press: () {},
//           ),
//           ProfileMenu(
//             text: "Log Out",
//             icon: "assets/icons/Log out.svg",
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? userEmail;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString("email");
    String? firstName = sharedPreferences.getString("firstName");
    String? lastName = sharedPreferences.getString("lastName");
    String? address = sharedPreferences.getString("address");
    String? phoneNumber = sharedPreferences.getString("phoneNumber");

    setState(() {
      userEmail = email;
      this.firstName = firstName;
      this.lastName = lastName;
      this.address = address;
      this.phoneNumber = phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          // ProfileMenu(
          //   text: "My Account",
          //   icon: "assets/icons/User Icon.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("My Account"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: $userEmail"),
                        Text("Nama Depan: $firstName"),
                        Text("Nama Belakang: $lastName"),
                        Text("Alamat: $address"),
                        Text("Alamat: $phoneNumber"),
                        // Add other user information as needed
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
