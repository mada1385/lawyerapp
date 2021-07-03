import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/consultaincard.dart';
import 'package:lawyerapp/components/consultaioncategory.dart';
import 'package:lawyerapp/components/primarylistview.dart';
import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:provider/provider.dart';

class Otherconsultataion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("cases")
                .where("lawfield",
                    isEqualTo:
                        Provider.of<Userprovider>(context).user["lawfield"])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                    child: Theme(
                        data: ThemeData(accentColor: k_primarycolor),
                        child: CircularProgressIndicator()));
              else
                return Primarylistveiw(
                    children: snapshot.data.documents
                        .map<Widget>((e) => Consultaioncard(
                              refrence: e.reference.documentID,
                              concult: e["case"],
                              username: e["user"]["full_name"],
                              firstbuttonhight: true,
                              replies: e["replies"],
                            ))
                        .toList());
            }));
  }
}
