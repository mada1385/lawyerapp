import 'package:flutter/material.dart';
import 'package:lawyerapp/components/circleavatar.dart';
import 'package:lawyerapp/components/texts.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/screens/lawscreen.dart';
import 'package:lawyerapp/screens/newsscreen.dart';
import 'package:lawyerapp/screens/reservationscreen.dart';
import 'aboutscreen.dart';
import 'consultaionScreen.dart';

enum TabItem { red, green, blue }

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List widgetOptions = <Widget>[
    Newsscreen(),
    Lawscreen(),
    Reservationscreen(),
    Consultaationscreen(),
    Aboutuserscreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(child: Container(color: k_backgroundcolor,height: double.infinity,width: double.infinity,child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[ SizedBox(height: 20,), SafeArea(child: CircleAvatar(backgroundColor: Colors.white,minRadius: 40.0,))],),),),
      backgroundColor: Color(0xff282828),
      appBar: AppBar(
        bottomOpacity: 0.0,
        backgroundColor: k_backgroundcolor,
        title: k_title,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: k_backgroundcolor,
        selectedIconTheme: IconThemeData(color: k_primarycolor),
        selectedLabelStyle: TextStyle(color: k_primarycolor),
        unselectedItemColor: k_secondrycolor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(
              Icons.sms_failed,
            ),
            title: Text('news'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.book),
            title: Text('the law'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.point_of_sale),
            title: Text('Reservation'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.message),
            title: Text('consultant'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Goldcircleavatar(
              size: 30,
            ),
            title: Text('consultant'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: k_primarycolor,
        onTap: _onItemTapped,
      ),
    );
  }
}
