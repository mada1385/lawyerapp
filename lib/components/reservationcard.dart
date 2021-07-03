import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/circleavatar.dart';
import 'package:lawyerapp/components/slideable.dart';
import 'package:lawyerapp/components/texts.dart';
import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/constants/decoration.dart';
import 'package:provider/provider.dart';

class Reservationcard extends StatefulWidget {
  final String lawyername, date, time, address, casebrirf, phonenumber, ref;

  const Reservationcard(
      {Key key,
      this.lawyername,
      this.date,
      this.time,
      this.address,
      this.casebrirf,
      this.phonenumber,
      this.ref})
      : super(key: key);
  @override
  _ReservationcardState createState() => _ReservationcardState();
}

class _ReservationcardState extends State<Reservationcard> {
  double hight = double.infinity;
  double width = 353;
  double iconsize = 30;
  double padding = 10;
  @override
  Widget build(BuildContext context) {
    return SlideMenu(
      menuItems: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              Firestore.instance
                  .collection("registration")
                  .document(widget.ref)
                  .delete();
            });
          },
          child: Goldtext(string: "Cancel"),
          color: Colors.transparent,
        )
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Container(
          width: width,
          height: hight,
          // color: koldpapper,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Goldcircleavatar(
                      size: 70,
                    ),
                  ),
                  Flexible(
                      child: Goldtext(
                    string: widget.lawyername,
                    fontWeight: FontWeight.w600,
                    fontsize: 25,
                  )),
                ],
              ),
              // SizedBox(height: 20,),
              // Text("name of the lawyer"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 2,
                color: k_primarycolor,
                width: double.infinity,
              ),
              Resevationrow(
                label: "date",
                value: widget.date,
              ),
              Resevationrow(
                label: "Time",
                value: widget.time,
              ),
              Resevationrow(
                label: "Phone Number",
                value: widget.phonenumber,
              ),
              Resevationrow(label: "case brief", value: widget.casebrirf)
            ],
          ),
          decoration: kdecorationgoldaccent,
        ),
      ),
    );
  }
}

class Resevationrow extends StatelessWidget {
  final String label;
  final String value;
  const Resevationrow({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Reservationtext(
          text: label,
          label: true,
        ),
        Reservationtext(
          text: ":",
          label: false,
        ),
        Reservationtext(text: value, label: false),
      ],
    );
  }
}

class Reservationtext extends StatelessWidget {
  final String text;
  final bool label;
  const Reservationtext({@required this.text, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: label == true ? 10 : 0),
        child:
            Goldtext(string: text, fontWeight: FontWeight.w400, fontsize: 16),
      ),
    );
  }
}
