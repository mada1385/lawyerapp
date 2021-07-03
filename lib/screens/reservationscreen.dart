import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/reservationcard.dart';
import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/constants/decoration.dart';
import 'package:provider/provider.dart';

class Reservationscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 50),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("registration")
                .where("lawyerid",
                    isEqualTo: Provider.of<Userprovider>(context, listen: false)
                        .userid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                    child: Theme(
                        data: ThemeData(accentColor: k_primarycolor),
                        child: CircularProgressIndicator()));
              else
                return ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.documents
                        .map<Widget>((e) => Builder(
                            builder: (context) => Reservationcard(
                                  ref: e.reference.documentID,
                                  casebrirf: e["case_brief"],
                                  lawyername: e["user"]["full_name"],
                                  date: e["date"],
                                  time: e["time"],
                                  phonenumber: e["phone_number"],
                                )))
                        .toList());
            }),
      ),
    );
  }
}
