import 'package:flutter/material.dart';
import 'package:lawyerapp/components/primaryiconbtn.dart';
import 'package:lawyerapp/components/reservationcard.dart';
import 'package:lawyerapp/components/texts.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/components/dropdownitem.dart';
import 'package:lawyerapp/screens/reservationscreen.dart';

class Findyouravocatoscreen extends StatefulWidget {
  List screens = <Widget>[Reservationscreen()];
  int screencontrol = 0;

  @override
  _FindyouravocatoscreenState createState() => _FindyouravocatoscreenState();
}

class _FindyouravocatoscreenState extends State<Findyouravocatoscreen> {
  PageController _myPage;
  var selectedPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: k_backgroundcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        widget.screencontrol = 0;
                        print(widget.screencontrol);
                      });
                    },
                    color: widget.screencontrol == 0
                        ? k_primarycolor
                        : k_backgroundcolor,
                    child: Text(
                      "find your avocato",
                      style: TextStyle(
                          color: widget.screencontrol == 0
                              ? k_backgroundcolor
                              : k_primarycolor),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        widget.screencontrol = 1;
                        print(widget.screencontrol);
                      });
                    },
                    child: Text("your resevation",
                        style: TextStyle(
                            color: widget.screencontrol == 1
                                ? k_backgroundcolor
                                : k_primarycolor)),
                    color: widget.screencontrol == 1
                        ? k_primarycolor
                        : k_backgroundcolor,
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              child: widget.screens[widget.screencontrol],
            ))
          ],
        ),
      ),
    );
  }
}
