import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahal_cash_prod/add_mtn_uganda_recipient_screen.dart';
import 'package:sahal_cash_prod/add_recipient_screen.dart';
import 'package:sahal_cash_prod/login_screen.dart';
import 'package:sahal_cash_prod/progress_dialog.dart';
import 'package:sahal_cash_prod/select_recipient_screen.dart';
import 'package:sahal_cash_prod/send_with_mpesa_screen.dart';
import 'API.dart';
import 'dashboard_screen.dart';


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddMtnUgandaRecipientScreen extends StatefulWidget {
  final String from_country;
  final String to_country;
  final String selected_remittance;
  final String from_country_currency_code;
  final String to_country_currency_code;
  final String from_country_flag;
  final String to_country_flag;
  final double send_amount;
  final double receive_amount;
  final double fees;
  final double send_total;


  AddMtnUgandaRecipientScreen({
    required this.from_country,
    required this.to_country,
    required this.selected_remittance,
    required this.from_country_currency_code,
    required this.to_country_currency_code,
    required this.from_country_flag,
    required this.to_country_flag,
    required this.send_amount,
    required this.receive_amount,
    required this.fees,
    required this.send_total,

    Key? key,
  }) : super(key: key);

  @override
  State<AddMtnUgandaRecipientScreen> createState() => _AddMtnUgandaRecipientScreenState();
}

class _AddMtnUgandaRecipientScreenState extends State<AddMtnUgandaRecipientScreen> {
  late String from_country;
  late String to_country;
  late String selected_remittance;
  late String from_country_currency_code;
  late String to_country_currency_code;
  late String from_country_flag;
  late String to_country_flag;
  late double send_amount;
  late double receive_amount;
  late double fees;
  late double send_total;

  @override
  void initState() {
    super.initState();
    from_country = widget.from_country;
    to_country = widget.to_country;
    selected_remittance = widget.selected_remittance;
    from_country_currency_code = widget.from_country_currency_code;
    to_country_currency_code = widget.to_country_currency_code;
    from_country_flag = widget.from_country_flag;
    to_country_flag = widget.to_country_flag;
    send_amount = widget.send_amount;
    receive_amount = widget.receive_amount;
    fees = widget.fees;
    send_total = widget.send_total;

  }


  API sahalAPI = API();

  Color app_color = Color(0xFF06800B);

  bool _obscureText = true;

  final storage = FlutterSecureStorage();

  String _selectedCountryCode = '+256'; // default selected country code

  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtMiddleName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtConfirmMobileNumber = TextEditingController();



  void add_recipient(String first_name, String last_name, String email, String mobile_number, String selected_country_code) {
    //Settle to MTN

    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SendWithMpesaScreen(
            from_country: from_country,
            to_country: to_country,
            selected_remittance: selected_remittance,
            from_country_currency_code: from_country_currency_code,
            to_country_currency_code: to_country_currency_code,
            from_country_flag: from_country_flag,
            to_country_flag: to_country_flag,
            send_amount: send_amount,
            receive_amount: receive_amount,
            fees: fees,
            send_total: send_total,
            first_name: first_name,
            last_name: last_name,
            mobile_number: mobile_number,
            selected_country_code: selected_country_code
        ),
      ),
    );


  }

  // list of dropdown menu items
  List<DropdownMenuItem<String>> _countryCodeDropdownMenuItems() {
    return [
      DropdownMenuItem<String>(value: '+256', child: Text('+256')),
    ];  // add more items as needed  ];
  }

// function to handle country code dropdown value change
  void _onCountryCodeChanged(String? value) {
    setState(() {
      _selectedCountryCode = value ?? _selectedCountryCode;
    });
  }

  InputDecoration buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[500],
        backgroundColor: Colors.grey[200], // Set the background color of the label text to white
      ),
      filled: true,
      fillColor: Colors.grey[200],
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(),
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 14,
        fontFamily: 'UbuntuRegular',
      ),
      focusColor: app_color,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: app_color, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[200]!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: app_color,
                  size: 30.0,
                ), onPressed: () {
                Navigator.pop(context);
              },
              ),
              title: null,
            ),
            Container(
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top row
                    Container(
                      margin: EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Column(

                                children: [

                                  Row(
                                    children: [
                                      Expanded(child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20,right: 10),
                                          child: Text(
                                            "Recipient details",
                                            style: TextStyle(
                                              color: app_color,
                                              fontSize: 26,
                                              fontFamily: 'UbuntuBold',
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20,right: 10),
                                          child: Text(
                                            "Enter information about the person you want to send money to",
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15,
                                              fontFamily: 'UbuntuBold',
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 40),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                controller: txtFirstName,
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.next,
                                                decoration: buildInputDecoration('First name', 'First name'),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'UbuntuRegular'),
                                              ),
                                            ),// Add s
                                            SizedBox(height: 15),
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                controller: txtLastName,
                                                keyboardType: TextInputType.text,
                                                textInputAction: TextInputAction.next,
                                                decoration: buildInputDecoration('Last name', 'Last name'),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'UbuntuRegular'),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                controller: txtEmail,
                                                keyboardType: TextInputType.emailAddress,
                                                textInputAction: TextInputAction.next,
                                                decoration: buildInputDecoration('Email', 'Email'),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'UbuntuRegular'),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                keyboardType: TextInputType.phone,
                                                textInputAction: TextInputAction.next,
                                                controller: txtMobileNumber,
                                                decoration: InputDecoration(
                                                  labelText: 'MTN Mobile Number',

                                                  labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'UbuntuRegular',
                                                    color: Colors.grey[500],
                                                    backgroundColor: Colors.grey[200], // Set the background color of the label text to white
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: app_color,width: 2),
                                                  ),
                                                  prefixIcon: SizedBox(
                                                    width: 95,
                                                    height: 50,
                                                    child: DropdownButtonFormField<String>(
                                                      value: _selectedCountryCode,
                                                      items: _countryCodeDropdownMenuItems(),
                                                      onChanged: _onCountryCodeChanged,
                                                      decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(4.2),
                                                            bottomLeft: Radius.circular(4.2),
                                                          ),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'UbuntuRegular',
                                                        color: Colors.grey[500],
                                                      ),
                                                      dropdownColor: Colors.white,
                                                      iconSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(
                                              height: 48,
                                              child: TextFormField(
                                                keyboardType: TextInputType.phone,
                                                textInputAction: TextInputAction.next,
                                                controller: txtConfirmMobileNumber,
                                                decoration: InputDecoration(
                                                  labelText: 'Confirm MTN mobile Number',
                                                  labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'UbuntuRegular',
                                                    color: Colors.grey[500],
                                                    backgroundColor: Colors.grey[200], // Set the background color of the label text to white
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.grey[200],
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: Colors.transparent),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4.2),
                                                    borderSide: BorderSide(color: app_color,width: 2),
                                                  ),
                                                  prefixIcon: SizedBox(
                                                    width: 95,
                                                    height: 50,
                                                    child: DropdownButtonFormField<String>(
                                                      value: _selectedCountryCode,
                                                      items: _countryCodeDropdownMenuItems(),
                                                      onChanged: _onCountryCodeChanged,
                                                      decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                        filled: true,
                                                        fillColor: Colors.grey[200],
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(4.2),
                                                            bottomLeft: Radius.circular(4.2),
                                                          ),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'UbuntuRegular',
                                                        color: Colors.grey[500],
                                                      ),
                                                      dropdownColor: Colors.white,
                                                      iconSize: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),

                                            SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      proceed();
                                                    },
                                                    child: Text('Continue',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: 'UbuntuBold',
                                                      ),),
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 45.5),
                                                      backgroundColor: app_color, // Set the button background color
                                                      foregroundColor: Colors.white, // Set the text color
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        // Set the radius to 20
                                                      ),
                                                      elevation: 0, // Remove the button elevation
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 40),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))

                            ],
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ) ,

            )

          ],
        ),
      ),
    );
  }

  void proceed() {


    String first_name  = txtFirstName.text;
    String last_name  = txtLastName.text;
    String email  = txtEmail.text;
    String mobile_number  = txtMobileNumber.text;
    String confirm_mobile_number  = txtConfirmMobileNumber.text;
    String selected_country_code = _selectedCountryCode;

    if(first_name.isEmpty || last_name.isEmpty || email.isEmpty || mobile_number.isEmpty || confirm_mobile_number.isEmpty){
      Fluttertoast.showToast(
        msg: 'Please make sure you fill in all fields first.',
        toastLength: Toast.LENGTH_SHORT,
      );
    }else{
      if(mobile_number != confirm_mobile_number){
        Fluttertoast.showToast(
          msg: 'Confirm mobile number correctly',
          toastLength: Toast.LENGTH_SHORT,
        );
      }else{
        if(isEmailValid(email)){
          if(mobile_number.length != 9){
            Fluttertoast.showToast(
              msg: 'Invalid mobile number entered',
              toastLength: Toast.LENGTH_SHORT,
            );
          }else{
            showConfirmationDialog(first_name,last_name,email,mobile_number,selected_country_code);

          }
        }else{
          Fluttertoast.showToast(
            msg: 'Invalid email address',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
    }


  }
  bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
    );

    return emailRegex.hasMatch(email);
  }



  void showConfirmationDialog(String first_name, String last_name, String email, String mobile_number, String selected_country_code) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to send $to_country_currency_code $receive_amount to $first_name, $last_name of phone number $selected_country_code$mobile_number in $to_country?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                // Call the add_recipient function or perform any other actions
                add_recipient(first_name, last_name, email, mobile_number, selected_country_code);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }



}
