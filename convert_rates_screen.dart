import 'package:flutter/material.dart';
import 'package:sahal_cash_prod/select_recipient_screen.dart';
import 'dashboard_screen.dart';

class ConvertRatesScreen extends StatefulWidget {
  final String from_country;
  final String to_country;
  final String selected_remittance;
  final String from_country_currency_code;
  final String to_country_currency_code;
  final String from_country_flag;
  final String to_country_flag;

  ConvertRatesScreen({
    required this.from_country,
    required this.to_country,
    required this.selected_remittance,

    required this.from_country_currency_code,
    required this.to_country_currency_code,
    required this.from_country_flag,
    required this.to_country_flag,
    Key? key,
  }) : super(key: key);

  @override
  State<ConvertRatesScreen> createState() => _ConvertRatesScreenState();
}

class _ConvertRatesScreenState extends State<ConvertRatesScreen> {
  late String fromCountry;
  late String toCountry;
  late String selectedRemittance;
  late String from_country_currency_code;
  late String to_country_currency_code;
  late String from_country_flag;
  late String to_country_flag;
  @override
  void initState() {
    super.initState();
    fromCountry = widget.from_country;
    toCountry = widget.to_country;
    selectedRemittance = widget.selected_remittance;
    from_country_currency_code = widget.from_country_currency_code;
    to_country_currency_code = widget.to_country_currency_code;
    from_country_flag = widget.from_country_flag;
    to_country_flag = widget.to_country_flag;

  }


  InputDecoration buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Color(0xFF527693),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      filled: true,
      fillColor: Colors.grey[200],
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(),
      hintText: hint,
      hintStyle: TextStyle(
        color: Color(0xFF527693),
        fontSize: 14,
        fontFamily: 'UbuntuRegular',
      ),
      focusColor: Color(0xFF527693),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF527693), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    Color app_color = Color(0xFF06800B);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
        title: Text("Convert Rates",
          style: TextStyle(
            color: app_color,
            fontFamily: 'UbuntuBold',
          ),),
      ),
      body: Scaffold(
        backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,

                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only( left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black,
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
                                backgroundImage: NetworkImage(from_country_flag),
                              ),
                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                'You Send',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'UbuntuRegular',
                                ),
                              ),

                              SizedBox(height: 10),

                              // add some space between the image and the text
                              Text(
                                from_country_currency_code,
                                style: TextStyle(fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UbuntuBold',),
                              ),
                              SizedBox(
                                height: 30,
                                width: 100,
                                child: TextFormField(
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'UbuntuRegular'),
                                  decoration: InputDecoration(
                                    hintText: '0.000',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF527693),
                                      fontFamily: 'UbuntuRegular',
                                    ),
                                  ),
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
                                backgroundImage: NetworkImage(to_country_flag),
                              ),
                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                'They Receive',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'UbuntuRegular',
                                ),
                              ),

                              SizedBox(height: 10),
                              // add some space between the image and the text
                              Text(
                                to_country_currency_code,
                                style: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UbuntuBold',),
                              ),
                              SizedBox(
                                height: 30,
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'UbuntuRegular'),
                                  decoration: InputDecoration(
                                    hintText: '0.000',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF527693),
                                      fontFamily: 'UbuntuRegular',
                                    ),
                                  ),
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
                SizedBox(height: 25,),

                Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Exchange Rate 1 USD = 0.798 GBP",
                            style: TextStyle(
                              color: app_color,
                              fontSize: 15,
                              fontFamily: 'UbuntuBold',
                            ),
                          ),
                        ),

                      ),

                    ]

                ),
                //Exchange rates
                SizedBox(height: 20,),

                Expanded(
                    child: SingleChildScrollView(
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
                            child: Row(
                              children: [
                                Expanded(child:
                                  Container(
                                    margin: EdgeInsets.only(top: 3, bottom:3),
                                    child: ListTile(
                                      leading: Text('They Receive',
                                        style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                      ),
                                      trailing: Text('375.99 GBP',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontFamily: 'UbuntuBold',
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(child:
                                Container(
                                  margin: EdgeInsets.only(top: 3, bottom:3),
                                  child: ListTile(
                                    leading: Text('You Send',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                    trailing: Text('469.46 USD',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                  ),
                                ),
                                )

                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(child:
                                Container(
                                  margin: EdgeInsets.only(top: 3, bottom:3),
                                  child: ListTile(
                                    leading: Text('Fees',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                    trailing: Text('23.47 USD',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                  ),
                                ),
                                ),

                                SizedBox(height: 20)

                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(child:
                                Container(
                                  margin: EdgeInsets.only(top: 3, bottom:3),
                                  child: ListTile(
                                    leading: Text('Total To Pay',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                    trailing: Text('492.93 USD',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'UbuntuBold',
                                      ),
                                    ),
                                  ),
                                ),
                                )

                              ],
                            ),
                          )
                        ],
                ),
                    )),

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
                              MaterialPageRoute(builder: (context) => SelectRecipientScreen()),
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
          )
      ),
    );
  }
}
