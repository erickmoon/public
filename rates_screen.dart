import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'convert_rates_screen.dart';

import 'API.dart';
import 'dashboard_screen.dart';
import 'forgot_password_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahal_cash_prod/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  Color app_color = Color(0xFF06800B);

  late List<dynamic> countries = [];
  List<String> remittance_types = [];

  bool isChecked = false;

  Future<List<dynamic>> _getCountries() async {
    ProgressDialogManager progressDialogManager = ProgressDialogManager();
    progressDialogManager.showProgressDialog(context, title: "Loading", message: "Getting countries and rates...");

    var headers = {
      'Content-Type': 'application/json'
    };
    API sahalAPI = API(); // Create an instance of the API class
    String apiURL = sahalAPI.apiURL; // Access the apiURL property

    var request = http.Request('POST', Uri.parse(apiURL));
    request.body = json.encode({
      "api_key": sahalAPI.apiKEY,
      "consumer_key": sahalAPI.consumerKEY,
      "service": "get_countries",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      progressDialogManager.hideProgressDialog();
      Map<String, dynamic> jsonResponse = json.decode(responseBody);

      String message = jsonResponse['message'];

      if (message == "success") {
        List<dynamic> countries = jsonResponse['countries'];
        return countries; // Return the countries array
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong. Check your internet connection', toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      progressDialogManager.hideProgressDialog();
      print(response.reasonPhrase);
      Fluttertoast.showToast(msg: 'Something went wrong. Check your internet connection', toastLength: Toast.LENGTH_SHORT);
    }

    return []; // Return an empty array if there was an error
  }

  void initState() {
    super.initState();
    fetchCountries();
  }

  void fetchCountries() async {
    countries = await _getCountries();
  }
  String _selectedCountry1 = 'Select country';
  String _selectedCurrency1 = 'Currency';
  String _selectedFlagUrl1 =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Blue_sky_white_clouds.jpg/320px-Blue_sky_white_clouds.jpgm';

  String _selectedCountry = 'Select country';
  String _selectedCurrency = 'Currency';
  String _selectedFlagUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Blue_sky_white_clouds.jpg/320px-Blue_sky_white_clouds.jpg';




  void _openCountrySelection() async {
    if(countries.isEmpty) {
      countries = await _getCountries();
    }
    final selectedCountry = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              "From Country",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'UbuntuBold',
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                final country = countries[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(country['country_flag']),
                  ),
                  title: Text(
                    country['country_name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'UbuntuRegular',
                    ),
                  ),
                  onTap: () {
                    _selectedCountry = country['country_name'];
                    _updateSelectedCountry(country['country_name']);
                    Navigator.pop(context, country['country_name']);
                  },
                );
              },
            ),
          ],
        );
      },
    );

    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
        var countryData = countries.firstWhere((country) =>
        country['country_name'] == _selectedCountry,
            orElse: () => null);

        if (countryData != null) {
          _selectedCurrency = countryData['currency_code'];
          _selectedFlagUrl = countryData['country_flag'];
        }
      });
    }

  }
  void _updateSelectedCountry(String country) {
    _getRemittanceTypes();
    setState(() {
      _selectedCountry = country;
      var countryData = countries.firstWhere(
            (country) => country['country_name'] == _selectedCountry,
        orElse: () => null,
      );
      _getRemittanceTypes();
      if (countryData != null) {
        _selectedCurrency = countryData['currency_code'];
        _selectedFlagUrl = countryData['country_flag'];
      }
    });
  }

  void _openCountrySelection1() async {
    if (countries.isEmpty) {
      countries = await _getCountries();
    }

    showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(
              "To Country",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'UbuntuBold',
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                final country = countries[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(country['country_flag']),
                  ),
                  title: Text(
                    country['country_name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'UbuntuRegular',
                    ),
                  ),
                  onTap: () {
                    _selectedCountry1 = country['country_name'];
                    _updateSelectedCountry1(country['country_name']);
                    Navigator.pop(context, country['country_name']);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _updateSelectedCountry1(String country) async {
    if (countries.isEmpty) {
      countries = await _getCountries();
    }
      _getRemittanceTypes();

    setState(() {
      _selectedCountry1 = country;
      var countryData = countries.firstWhere(
            (country) => country['country_name'] == _selectedCountry1,
        orElse: () => null,
      );

      if (countryData != null) {
        _selectedCurrency1 = countryData['currency_code'];
        _selectedFlagUrl1 = countryData['country_flag'];
      }
    });
  }
  void _getRemittanceTypes() async{

    if(_selectedCountry == "Kenya" && _selectedCountry1 == "Uganda"){
      remittance_types.add("MTN");
      remittance_types.add("M-Pesa");
      remittance_types.add("Airtel Money");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color app_color = Color(0xFF527693);
    Color buttons_color = Color(0xFF8C782E);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 30.0,
          ), onPressed: () {
          Navigator.pop(context);
        },
        ),
        title: Text("Check Rates",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'UbuntuBold',
          ),),
      ),
      body: Scaffold(
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tap to select country",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 15,
                              fontFamily: 'UbuntuBold',
                            ),
                          ),
                        ),

                      ),

                    ]

                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,

                      child: GestureDetector(
                        onTap: _openCountrySelection,
                        child: Container(
                          margin: EdgeInsets.only( left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFFFFFFF),
                            border: Border.all(
                              width: 2,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),

                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 24, // adjust the radius as needed
                                backgroundImage: NetworkImage(_selectedFlagUrl),
                              ),

                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                _selectedCurrency,
                                style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UbuntuBold',),
                              ),
                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                'Sending from',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: 'UbuntuRegular',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                _selectedCountry,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'UbuntuBold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      ,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 1,

                      child: GestureDetector(
                        onTap: _openCountrySelection1,

                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFFEEEEEE),

                          ),


                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 24, // adjust the radius as needed
                                backgroundImage: NetworkImage(_selectedFlagUrl1),
                              ),

                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                _selectedCurrency1,
                                style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UbuntuBold',),
                              ),
                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                'Sending to',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: 'UbuntuRegular',
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                _selectedCountry1,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'UbuntuBold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      ,
                    ),
                  ],
                ),
                //Remittance types

                SizedBox(height: 25,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFEEEEEE),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Remittance Type",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontFamily: 'UbuntuBold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: remittance_types.length,
                            itemBuilder: (BuildContext context, int index) {
                              final remittance = remittance_types[index];
                              bool isChecked = false; // Set initial checkbox state

                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 6, bottom: 6),
                                    child: ListTile(
                                      leading: Icon(Icons.phone_android),
                                      title: Text(
                                        remittance,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: 'UbuntuRegular',
                                        ),
                                      ),
                                      trailing: Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value ?? false;
                                          });
                                        },
                                        activeColor: Color(0xFF034D06),
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                        ),

                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),

                //Button
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConvertRatesScreen()),
                            );
                          },
                          label: Text('Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'UbuntuBold',
                            ),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.5),
                            backgroundColor: app_color, // Set the button background color
                            foregroundColor: Colors.white, // Set the text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // Set the radius to 20
                            ),
                            elevation: 0, // Remove the button elevation
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30)



            ],

            ),
          ),
      ),
    );


  }




}
