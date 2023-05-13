import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sahal_cash_prod/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Color app_color = Color(0xFF06800B);

  bool _obscureText = true;

  String _selectedCountryCode = '+1'; // default selected country code


// list of dropdown menu items
  List<DropdownMenuItem<String>> _countryCodeDropdownMenuItems() {
    return [
      DropdownMenuItem<String>(value: '+1', child: Text('+1')),
      DropdownMenuItem<String>(value: '+7', child: Text('+7')),
      DropdownMenuItem<String>(value: '+20', child: Text('+20')),
      DropdownMenuItem<String>(value: '+27', child: Text('+27')),
      DropdownMenuItem<String>(value: '+30', child: Text('+30')),
      DropdownMenuItem<String>(value: '+31', child: Text('+31')),
      DropdownMenuItem<String>(value: '+32', child: Text('+32')),
      DropdownMenuItem<String>(value: '+33', child: Text('+33')),
      DropdownMenuItem<String>(value: '+34', child: Text('+34')),
      DropdownMenuItem<String>(value: '+36', child: Text('+36')),
      DropdownMenuItem<String>(value: '+39', child: Text('+39')),
      DropdownMenuItem<String>(value: '+40', child: Text('+40')),
      DropdownMenuItem<String>(value: '+41', child: Text('+41')),
      DropdownMenuItem<String>(value: '+43', child: Text('+43')),
      DropdownMenuItem<String>(value: '+44', child: Text('+44')),
      DropdownMenuItem<String>(value: '+45', child: Text('+45')),
      DropdownMenuItem<String>(value: '+46', child: Text('+46')),
      DropdownMenuItem<String>(value: '+47', child: Text('+47')),
      DropdownMenuItem<String>(value: '+48', child: Text('+48')),
      DropdownMenuItem<String>(value: '+49', child: Text('+49')),
      DropdownMenuItem<String>(value: '+51', child: Text('+51')),
      DropdownMenuItem<String>(value: '+52', child: Text('+52')),
      DropdownMenuItem<String>(value: '+53', child: Text('+53')),
      DropdownMenuItem<String>(value: '+54', child: Text('+54')),
      DropdownMenuItem<String>(value: '+55', child: Text('+55')),
      DropdownMenuItem<String>(value: '+56', child: Text('+56')),
      DropdownMenuItem<String>(value: '+57', child: Text('+57')),
      DropdownMenuItem<String>(value: '+58', child: Text('+58')),
      DropdownMenuItem<String>(value: '+60', child: Text('+60')),
      DropdownMenuItem<String>(value: '+61', child: Text('+61')),
      DropdownMenuItem<String>(value: '+62', child: Text('+62')),
      DropdownMenuItem<String>(value: '+63', child: Text('+63')),
      DropdownMenuItem<String>(value: '+64', child: Text('+64')),
      DropdownMenuItem<String>(value: '+65', child: Text('+65')),
      DropdownMenuItem<String>(value: '+66', child: Text('+66')),
      DropdownMenuItem<String>(value: '+81', child: Text('+81')),
      DropdownMenuItem<String>(value: '+82', child: Text('+82')),
      DropdownMenuItem<String>(value: '+84', child: Text('+84')),
      DropdownMenuItem<String>(value: '+86', child: Text('+86')),
      DropdownMenuItem<String>(value: '+90', child: Text('+90')),
      DropdownMenuItem<String>(value: '+91', child: Text('+91')),
      DropdownMenuItem<String>(value: '+92', child: Text('+92')),
      DropdownMenuItem<String>(value: '+93', child: Text('+93')),
      DropdownMenuItem<String>(value: '+94', child: Text('+94')),
      DropdownMenuItem<String>(value: '+95', child: Text('+95')),
      DropdownMenuItem<String>(value: '+98', child: Text('+98')),
      DropdownMenuItem<String>(value: '+211', child: Text('+211')),
      DropdownMenuItem<String>(value: '+212', child: Text('+212')),
      DropdownMenuItem<String>(value: '+213', child: Text('+213')),
      DropdownMenuItem<String>(value: '+216', child: Text('+216')),
      DropdownMenuItem<String>(value: '+218', child: Text('+218')),
      DropdownMenuItem<String>(value: '+220', child: Text('+220')),
      DropdownMenuItem<String>(value: '+221', child: Text('+221')),
      DropdownMenuItem<String>(value: '+222', child: Text('+222')),
      DropdownMenuItem<String>(value: '+223', child: Text('+223')),
      DropdownMenuItem<String>(value: '+224', child: Text('+224')),
      DropdownMenuItem<String>(value: '+225', child: Text('+225')),
      DropdownMenuItem<String>(value: '+226', child: Text('+226')),
      DropdownMenuItem<String>(value: '+227', child: Text('+227')),
      DropdownMenuItem<String>(value: '+228', child: Text('+228')),
      DropdownMenuItem<String>(value: '+229', child: Text('+229')),
      DropdownMenuItem<String>(value: '+230', child: Text('+230')),
      DropdownMenuItem<String>(value: '+231', child: Text('+231')),
      DropdownMenuItem<String>(value: '+232', child: Text('+232')),
      DropdownMenuItem<String>(value: '+233', child: Text('+233')),
      DropdownMenuItem<String>(value: '+234', child: Text('+234')),
      DropdownMenuItem<String>(value: '+235', child: Text('+235')),
      DropdownMenuItem<String>(value: '+236', child: Text('+236')),
      DropdownMenuItem<String>(value: '+237', child: Text('+237')),
      DropdownMenuItem<String>(value: '+238', child: Text('+238')),
      DropdownMenuItem<String>(value: '+239', child: Text('+239')),
      DropdownMenuItem<String>(value: '+240', child: Text('+240')),
      DropdownMenuItem<String>(value: '+241', child: Text('+241')),
      DropdownMenuItem<String>(value: '+242', child: Text('+242')),
      DropdownMenuItem<String>(value: '+243', child: Text('+243')),
      DropdownMenuItem<String>(value: '+244', child: Text('+244')),
      DropdownMenuItem<String>(value: '+245', child: Text('+245')),
      DropdownMenuItem<String>(value: '+246', child: Text('+246')),
      DropdownMenuItem<String>(value: '+247', child: Text('+247')),
      DropdownMenuItem<String>(value: '+248', child: Text('+248')),
      DropdownMenuItem<String>(value: '+249', child: Text('+249')),
      DropdownMenuItem<String>(value: '+250', child: Text('+250')),
      DropdownMenuItem<String>(value: '+251', child: Text('+251')),
      DropdownMenuItem<String>(value: '+252', child: Text('+252')),
      DropdownMenuItem<String>(value: '+253', child: Text('+253')),
      DropdownMenuItem<String>(value: '+254', child: Text('+254')),
      DropdownMenuItem<String>(value: '+255', child: Text('+255')),
      DropdownMenuItem<String>(value: '+256', child: Text('+256')),
      DropdownMenuItem<String>(value: '+257', child: Text('+257')),
      DropdownMenuItem<String>(value: '+258', child: Text('+258')),
      DropdownMenuItem<String>(value: '+260', child: Text('+260')),
      DropdownMenuItem<String>(value: '+261', child: Text('+261')),
      DropdownMenuItem<String>(value: '+262', child: Text('+262')),
      DropdownMenuItem<String>(value: '+263', child: Text('+263')),
      DropdownMenuItem<String>(value: '+264', child: Text('+264')),
      DropdownMenuItem<String>(value: '+265', child: Text('+265')),
      DropdownMenuItem<String>(value: '+266', child: Text('+266')),
      DropdownMenuItem<String>(value: '+267', child: Text('+267')),
      DropdownMenuItem<String>(value: '+268', child: Text('+268')),
      DropdownMenuItem<String>(value: '+269', child: Text('+269')),
      DropdownMenuItem<String>(value: '+290', child: Text('+290')),
      DropdownMenuItem<String>(value: '+291', child: Text('+291')),
      DropdownMenuItem<String>(value: '+297', child: Text('+297')),
      DropdownMenuItem<String>(value: '+298', child: Text('+298')),
      DropdownMenuItem<String>(value: '+299', child: Text('+299')),
      DropdownMenuItem<String>(value: '+350', child: Text('+350')),
      DropdownMenuItem<String>(value: '+351', child: Text('+351')),
      DropdownMenuItem<String>(value: '+352', child: Text('+352')),
      DropdownMenuItem<String>(value: '+353', child: Text('+353')),
      DropdownMenuItem<String>(value: '+354', child: Text('+354')),
      DropdownMenuItem<String>(value: '+355', child: Text('+355')),
      DropdownMenuItem<String>(value: '+356', child: Text('+356')),
      DropdownMenuItem<String>(value: '+357', child: Text('+357')),
      DropdownMenuItem<String>(value: '+358', child: Text('+358')),
      DropdownMenuItem<String>(value: '+359', child: Text('+359')),
      DropdownMenuItem<String>(value: '+370', child: Text('+370')),
      DropdownMenuItem<String>(value: '+371', child: Text('+371')),
      DropdownMenuItem<String>(value: '+372', child: Text('+372')),
      DropdownMenuItem<String>(value: '+373', child: Text('+373')),
      DropdownMenuItem<String>(value: '+374', child: Text('+374')),
      DropdownMenuItem<String>(value: '+375', child: Text('+375')),
      DropdownMenuItem<String>(value: '+376', child: Text('+376')),
      DropdownMenuItem<String>(value: '+377', child: Text('+377')),
      DropdownMenuItem<String>(value: '+378', child: Text('+378')),
      DropdownMenuItem<String>(value: '+379', child: Text('+379')),
      DropdownMenuItem<String>(value: '+380', child: Text('+380')),
      DropdownMenuItem<String>(value: '+381', child: Text('+381')),
      DropdownMenuItem<String>(value: '+382', child: Text('+382')),
      DropdownMenuItem<String>(value: '+383', child: Text('+383')),
      DropdownMenuItem<String>(value: '+385', child: Text('+385')),
      DropdownMenuItem<String>(value: '+386', child: Text('+386')),
      DropdownMenuItem<String>(value: '+387', child: Text('+387')),
      DropdownMenuItem<String>(value: '+389', child: Text('+389')),
      DropdownMenuItem<String>(value: '+420', child: Text('+420')),
      DropdownMenuItem<String>(value: '+421', child: Text('+421')),
      DropdownMenuItem<String>(value: '+423', child: Text('+423')),
      DropdownMenuItem<String>(value: '+500', child: Text('+500')),
      DropdownMenuItem<String>(value: '+501', child: Text('+501')),
      DropdownMenuItem<String>(value: '+502', child: Text('+502')),
      DropdownMenuItem<String>(value: '+503', child: Text('+503')),
      DropdownMenuItem<String>(value: '+504', child: Text('+504')),
      DropdownMenuItem<String>(value: '+505', child: Text('+505')),
      DropdownMenuItem<String>(value: '+506', child: Text('+506')),
      DropdownMenuItem<String>(value: '+507', child: Text('+507')),
      DropdownMenuItem<String>(value: '+508', child: Text('+508')),
      DropdownMenuItem<String>(value: '+509', child: Text('+509')),
      DropdownMenuItem<String>(value: '+590', child: Text('+590')),
      DropdownMenuItem<String>(value: '+591', child: Text('+591')),
      DropdownMenuItem<String>(value: '+592', child: Text('+592')),
      DropdownMenuItem<String>(value: '+593', child: Text('+593')),
      DropdownMenuItem<String>(value: '+594', child: Text('+594')),
      DropdownMenuItem<String>(value: '+595', child: Text('+595')),
      DropdownMenuItem<String>(value: '+596', child: Text('+596')),
      DropdownMenuItem<String>(value: '+597', child: Text('+597')),
      DropdownMenuItem<String>(value: '+598', child: Text('+598')),
      DropdownMenuItem<String>(value: '+599', child: Text('+599')),
      DropdownMenuItem<String>(value: '+670', child: Text('+670')),
      DropdownMenuItem<String>(value: '+672', child: Text('+672')),
      DropdownMenuItem<String>(value: '+673', child: Text('+673')),
      DropdownMenuItem<String>(value: '+674', child: Text('+674')),
      DropdownMenuItem<String>(value: '+675', child: Text('+675')),
      DropdownMenuItem<String>(value: '+676', child: Text('+676')),
      DropdownMenuItem<String>(value: '+677', child: Text('+677')),
      DropdownMenuItem<String>(value: '+678', child: Text('+678')),
      DropdownMenuItem<String>(value: '+679', child: Text('+679')),
      DropdownMenuItem<String>(value: '+680', child: Text('+680')),
      DropdownMenuItem<String>(value: '+681', child: Text('+681')),
      DropdownMenuItem<String>(value: '+682', child: Text('+682')),
      DropdownMenuItem<String>(value: '+683', child: Text('+683')),
      DropdownMenuItem<String>(value: '+685', child: Text('+685')),
      DropdownMenuItem<String>(value: '+686', child: Text('+686')),
      DropdownMenuItem<String>(value: '+687', child: Text('+687')),
      DropdownMenuItem<String>(value: '+688', child: Text('+688')),
      DropdownMenuItem<String>(value: '+689', child: Text('+689')),
      DropdownMenuItem<String>(value: '+690', child: Text('+690')),
      DropdownMenuItem<String>(value: '+691', child: Text('+691')),
      DropdownMenuItem<String>(value: '+692', child: Text('+692')),
      DropdownMenuItem<String>(value: '+850', child: Text('+850')),
      DropdownMenuItem<String>(value: '+852', child: Text('+852')),
      DropdownMenuItem<String>(value: '+853', child: Text('+853')),
      DropdownMenuItem<String>(value: '+855', child: Text('+855')),
      DropdownMenuItem<String>(value: '+856', child: Text('+856')),
      DropdownMenuItem<String>(value: '+870', child: Text('+870')),
      DropdownMenuItem<String>(value: '+880', child: Text('+880')),
      DropdownMenuItem<String>(value: '+886', child: Text('+886')),
      DropdownMenuItem<String>(value: '+960', child: Text('+960')),
      DropdownMenuItem<String>(value: '+961', child: Text('+961')),
      DropdownMenuItem<String>(value: '+962', child: Text('+962')),
      DropdownMenuItem<String>(value: '+963', child: Text('+963')),
      DropdownMenuItem<String>(value: '+964', child: Text('+964')),
      DropdownMenuItem<String>(value: '+965', child: Text('+965')),
      DropdownMenuItem<String>(value: '+966', child: Text('+966')),
      DropdownMenuItem<String>(value: '+967', child: Text('+967')),
      DropdownMenuItem<String>(value: '+968', child: Text('+968')),
      DropdownMenuItem<String>(value: '+970', child: Text('+970')),
      DropdownMenuItem<String>(value: '+971', child: Text('+971')),
      DropdownMenuItem<String>(value: '+972', child: Text('+972')),
      DropdownMenuItem<String>(value: '+973', child: Text('+973')),
      DropdownMenuItem<String>(value: '+974', child: Text('+974')),
      DropdownMenuItem<String>(value: '+975', child: Text('+975')),
      DropdownMenuItem<String>(value: '+976', child: Text('+976')),
      DropdownMenuItem<String>(value: '+977', child: Text('+977')),
      DropdownMenuItem<String>(value: '+992', child: Text('+992')),
      DropdownMenuItem<String>(value: '+993', child: Text('+993')),
      DropdownMenuItem<String>(value: '+994', child: Text('+994')),
      DropdownMenuItem<String>(value: '+995', child: Text('+995')),
      DropdownMenuItem<String>(value: '+996', child: Text('+996')),
      DropdownMenuItem<String>(value: '+998', child: Text('+998'))
    ];  // add more items as needed  ];
  }

// function to handle country code dropdown value change
  void _onCountryCodeChanged(String? value) {
    setState(() {
      _selectedCountryCode = value ?? _selectedCountryCode;
    });
  }


  String _selectedCountry = 'Afghanistan';

  Map<String, String> _countryFlags = {
    'Afghanistan': '🇦🇫',
    'Albania': '🇦🇱',
    'Algeria': '🇩🇿',
    'Andorra': '🇦🇩',
    'Angola': '🇦🇴',
    'Antigua and Barbuda': '🇦🇬',
    'Argentina': '🇦🇷',
    'Armenia': '🇦🇲',
    'Australia': '🇦🇺',
    'Austria': '🇦🇹',
    'Azerbaijan': '🇦🇿',
    'Bahamas': '🇧🇸',
    'Bahrain': '🇧🇭',
    'Bangladesh': '🇧🇩',
    'Barbados': '🇧🇧',
    'Belarus': '🇧🇾',
    'Belgium': '🇧🇪',
    'Belize': '🇧🇿',
    'Benin': '🇧🇯',
    'Bhutan': '🇧🇹',
    'Bolivia': '🇧🇴',
    'Bosnia and Herzegovina': '🇧🇦',
    'Botswana': '🇧🇼',
    'Brazil': '🇧🇷',
    'Brunei': '🇧🇳',
    'Bulgaria': '🇧🇬',
    'Burkina Faso': '🇧🇫',
    'Burundi': '🇧🇮',
    'Cambodia': '🇰🇭',
    'Cameroon': '🇨🇲',
    'Canada': '🇨🇦',
    'Cape Verde': '🇨🇻',
    'Central African Republic': '🇨🇫',
    'Chad': '🇹🇩',
    'Chile': '🇨🇱',
    'China': '🇨🇳',
    'Colombia': '🇨🇴',
    'Comoros': '🇰🇲',
    'Congo (Congo-Brazzaville)': '🇨🇬',
    'Costa Rica': '🇨🇷',
    'Croatia': '🇭🇷',
    'Cuba': '🇨🇺',
    'Cyprus': '🇨🇾',
    'Czechia (Czech Republic)': '🇨🇿',
    'Denmark': '🇩🇰',
    'Djibouti': '🇩🇯',
    'Dominica': '🇩🇲',
    'Dominican Republic': '🇩🇴',
    'East Timor': '🇹🇱',
    'Ecuador': '🇪🇨',
    'Egypt': '🇪🇬',
    'El Salvador': '🇸🇻',
    'Equatorial Guinea': '🇬🇶',
    'Eritrea': '🇪🇷',
    'Estonia': '🇪🇪',
    'Eswatini': '🇸🇿',
    'Ethiopia': '🇪🇹',
    'Fiji': '🇫🇯',
    'Finland': '🇫🇮',
    'France': '🇫🇷',
    'Gabon': '🇬🇦',
    'Gambia': '🇬🇲',
    'Georgia': '🇬🇪',
    'Germany': '🇩🇪',
    'Ghana': '🇬🇭',
    'Greece': '🇬🇷',
    'Grenada': '🇬🇩',
    'Guatemala': '🇬🇹',
    'Guinea': '🇬🇳',
    'Guinea-Bissau': '🇬🇼',
    'Guyana': '🇬🇾',
    'Haiti': '🇭🇹',
    'Honduras': '🇭🇳',
    'Hungary': '🇭🇺',
    'Iceland': '🇮🇸',
    'India': '🇮🇳',
    'Indonesia': '🇮🇩',
    'Iran': '🇮🇷',
    'Iraq': '🇮🇶',
    'Ireland': '🇮🇪',
    'Israel': '🇮🇱',
    'Italy': '🇮🇹',
    'Jamaica': '🇯🇲',
    'Japan': '🇯🇵',
    'Jordan': '🇯🇴',
    'Kazakhstan': '🇰🇿',
    'Kenya': '🇰🇪',
    'Kiribati': '🇰🇮',
    'Korea, North': '🇰🇵',
    'Korea, South': '🇰🇷',
    'Kuwait': '🇰🇼',
    'Kyrgyzstan': '🇰🇬',
    'Laos': '🇱🇦',
    'Latvia': '🇱🇻',
    'Lebanon': '🇱🇧',
    'Lesotho': '🇱🇸',
    'Liberia': '🇱🇷',
    'Libya': '🇱🇾',
    'Liechtenstein': '🇱🇮',
    'Lithuania': '🇱🇹',
    'Luxembourg': '🇱🇺',
    'Madagascar': '🇲🇬',
    'Malawi': '🇲🇼',
    'Malaysia': '🇲🇾',
    'Maldives': '🇲🇻',
    'Mali': '🇲🇱',
    'Malta': '🇲🇹',
    'Marshall Islands': '🇲🇭',
    'Mauritania': '🇲🇷',
    'Mauritius': '🇲🇺',
    'Mexico': '🇲🇽',
    'Micronesia': '🇫🇲',
    'Moldova': '🇲🇩',
    'Monaco': '🇲🇨',
    'Mongolia': '🇲🇳',
    'Montenegro': '🇲🇪',
    'Morocco': '🇲🇦',
    'Mozambique': '🇲🇿',
    'Myanmar (formerly Burma)': '🇲🇲',
    'Namibia': '🇳🇦',
    'Nauru': '🇳🇷',
    'Nepal': '🇳🇵',
    'Netherlands': '🇳🇱',
    'New Zealand': '🇳🇿',
    'Nicaragua': '🇳🇮',
    'Niger': '🇳🇪',
    'Nigeria': '🇳🇬',
    'North Macedonia (formerly Macedonia)': '🇲🇰',
    'Norway': '🇳🇴',
    'Oman': '🇴🇲',
    'Pakistan': '🇵🇰',
    'Palau': '🇵🇼',
    'Panama': '🇵🇦',
    'Papua New Guinea': '🇵🇬',
    'Paraguay': '🇵🇾',
    'Peru': '🇵🇪',
    'Philippines': '🇵🇭',
    'Poland': '🇵🇱',
    'Portugal': '🇵🇹',
    'Qatar': '🇶🇦',
    'Romania': '🇷🇴',
    'Russia': '🇷🇺',
    'Rwanda': '🇷🇼',
    'Saint Kitts and Nevis': '🇰🇳',
    'Saint Lucia': '🇱🇨',
    'Saint Vincent and the Grenadines': '🇻🇨',
    'Samoa': '🇼🇸',
    'San Marino': '🇸🇲',
    'Sao Tome and Principe': '🇸🇹',
    'Saudi Arabia': '🇸🇦',
    'Senegal': '🇸🇳',
    'Serbia': '🇷🇸',
    'Seychelles': '🇸🇨',
    'Sierra Leone': '🇸🇱',
    'Singapore': '🇸🇬',
    'Slovakia': '🇸🇰',
    'Slovenia': '🇸🇮',
    'Solomon Islands': '🇸🇧',
    'Somalia': '🇸🇴',
    'South Africa': '🇿🇦',
    'South Sudan': '🇸🇸',
    'Spain': '🇪🇸',
    'Sri Lanka': '🇱🇰',
    'Sudan': '🇸🇩',
    'Suriname': '🇸🇷',
    'Sweden': '🇸🇪',
    'Switzerland': '🇨🇭',
    'Syria': '🇸🇾',
    'Taiwan': '🇹🇼',
    'Tajikistan': '🇹🇯',
    'Tanzania': '🇹🇿',
    'Thailand': '🇹🇭',
    'Togo': '🇹🇬',
    'Tonga': '🇹🇴',
    'Trinidad and Tobago': '🇹🇹',
    'Tunisia': '🇹🇳',
    'Turkey': '🇹🇷',
    'Turkmenistan': '🇹🇲',
    'Tuvalu': '🇹🇻',
    'Uganda': '🇺🇬',
    'Ukraine': '🇺🇦',
    'United Arab Emirates': '🇦🇪',
    'United Kingdom': '🇬🇧',
    'United States': '🇺🇸',
    'Uruguay': '🇺🇾',
    'Uzbekistan': '🇺🇿',
    'Vanuatu': '🇻🇺',
    'Vatican City': '🇻🇦',
    'Venezuela': '🇻🇪',
    'Vietnam': '🇻🇳',
    'Yemen': '🇾🇪',
    'Zambia': '🇿🇲',
    'Zimbabwe': '🇿🇼',
  };


  List<DropdownMenuItem<String>> _dropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    _countryFlags.forEach((country, flag) {
      items.add(DropdownMenuItem(
        value: country,
        child: Row(
          children: [
            Text(flag),
            SizedBox(width: 10),
            Text(country),
          ],
        ),
      ));
    });
    return items;
  }



  InputDecoration buildInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[500],
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
    Color app_color = Colors.green;
    Color buttons_color = Color(0xFF8C782E);

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
                                            "Sign up",
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
                                            "Enter your information to create an account",
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
                                  SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Expanded(child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          child: Text(
                                            "Sending from country",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'UbuntuRegular',
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox( height: 6),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: SizedBox(
                                          height: 50,
                                          child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),

                                              labelStyle: TextStyle(
                                                color: app_color,
                                                fontSize: 14,
                                                fontFamily: 'UbuntuRegular',
                                                backgroundColor: Colors.transparent,
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                                              border: OutlineInputBorder(),
                                              hintText: 'Sending from country',
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
                                            ),
                                            items: _dropdownMenuItems(),
                                            value: _selectedCountry,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedCountry = value!;
                                              });
                                            },
                                            isExpanded: true,
                                            itemHeight: 50, // set the itemHeight to match the height of the SizedBox
                                            iconSize: 24, // reduce the iconSize to fit the content within the SizedBox
                                            style: TextStyle(
                                              fontSize: 14, // reduce the font size to fit the content within the SizedBox
                                              fontFamily: 'UbuntuRegular',
                                              color: Colors.grey[500],
                                            ),
                                            dropdownColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      SizedBox(
                                        height: 48,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: buildInputDecoration('First name', 'First name'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'UbuntuRegular'),
                                        ),
                                      ),// Add some vertical spacing between the two text fields
                                      SizedBox(height: 15),
                                      SizedBox(
                                        height: 48,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: buildInputDecoration('Middle name', 'Middle name'),
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
                                          decoration: InputDecoration(
                                            labelText: 'Mobile Number',
                                            labelStyle: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 14,
                                              fontFamily: 'UbuntuRegular',
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
                                              width: 90,
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
                                          decoration: InputDecoration(
                                            labelText: 'Confirm mobile Number',
                                            labelStyle: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 14,
                                              fontFamily: 'UbuntuRegular',
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
                                              width: 90,
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
                                          obscureText: _obscureText,
                                          textInputAction: TextInputAction.next,
                                          decoration: buildInputDecoration('Password', 'Password')
                                              .copyWith(
                                            suffixIcon: IconButton(
                                              icon: Visibility(
                                                visible: _obscureText,
                                                child: Icon(Icons.visibility),
                                                replacement: Icon(Icons.visibility_off),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'UbuntuRegular',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      SizedBox(
                                        height: 48,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          decoration: buildInputDecoration('Referral code', 'Referral code'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'UbuntuRegular'),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Center(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'UbuntuBold',
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'By submitting the form, you agree to our ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Terms of Service',
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: Colors.blue,
                                                    ),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // Navigate to the Terms of Service page
                                                      },
                                                  ),
                                                  TextSpan(text: ' and ',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      )),
                                                  TextSpan(
                                                    text: 'Privacy Policy',
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: Colors.blue,
                                                    ),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // Navigate to the Privacy Policy page
                                                      },
                                                  ),
                                                  TextSpan(text: ' and allow us to contact you by email and SMS',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Create an account',
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already have an account? ",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontFamily: 'UbuntuBold',
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                              );
                                            },
                                            child: Text(
                                              "Log in",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: app_color,
                                                fontSize: 15,
                                                fontFamily: 'UbuntuBold',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 40),
                                    ],
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
}


