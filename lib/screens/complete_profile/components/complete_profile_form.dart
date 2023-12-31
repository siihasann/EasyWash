// import 'package:flutter/material.dart';
// import 'package:shop_app/components/custom_surfix_icon.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/components/form_error.dart';
// import 'package:shop_app/screens/otp/otp_screen.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';

// class CompleteProfileForm extends StatefulWidget {
//   @override
//   _CompleteProfileFormState createState() => _CompleteProfileFormState();
// }

// class _CompleteProfileFormState extends State<CompleteProfileForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String?> errors = [];
//   String? firstName;
//   String? lastName;
//   String? phoneNumber;
//   String? address;

//   void addError({String? error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }

//   void removeError({String? error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildFirstNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildLastNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPhoneNumberFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildAddressFormField(),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(40)),
//           DefaultButton(
//             text: "continue",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 Navigator.pushNamed(context, SignInScreen.routeName);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   TextFormField buildAddressFormField() {
//     return TextFormField(
//       onSaved: (newValue) => address = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kAddressNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kAddressNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Address",
//         hintText: "Enter your phone address",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon:
//             CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
//       ),
//     );
//   }

//   TextFormField buildPhoneNumberFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.phone,
//       onSaved: (newValue) => phoneNumber = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPhoneNumberNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPhoneNumberNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Phone Number",
//         hintText: "Enter your phone number",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//       ),
//     );
//   }

//   TextFormField buildLastNameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => lastName = newValue,
//       decoration: InputDecoration(
//         labelText: "Last Name",
//         hintText: "Enter your last name",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }

//   TextFormField buildFirstNameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => firstName = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kNamelNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kNamelNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "First Name",
//         hintText: "Enter your first name",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easywash_app/components/custom_surfix_icon.dart';
import 'package:easywash_app/components/default_button.dart';
import 'package:easywash_app/components/form_error.dart';
import 'package:easywash_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void saveUserData() {
    sharedPreferences?.setString("firstName", firstName!);
    sharedPreferences?.setString("lastName", lastName!);
    sharedPreferences?.setString("phoneNumber", phoneNumber!);
    sharedPreferences?.setString("address", address!);
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Data berhasil disimpan. Silakan sign in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         buildFirstNameFormField(),
  //         SizedBox(height: getProportionateScreenHeight(30)),
  //         buildLastNameFormField(),
  //         SizedBox(height: getProportionateScreenHeight(30)),
  //         buildPhoneNumberFormField(),
  //         SizedBox(height: getProportionateScreenHeight(30)),
  //         buildAddressFormField(),
  //         FormError(errors: errors),
  //         SizedBox(height: getProportionateScreenHeight(40)),
  //         DefaultButton(
  //           text: "Continue",
  //           press: () {
  //             if (_formKey.currentState!.validate()) {
  //               _formKey.currentState!.save();
  //               saveUserData();
  //               Navigator.pushNamed(context, SignInScreen.routeName);
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                saveUserData();
                showSuccessDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
