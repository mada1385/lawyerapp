import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/newscard.dart';
import 'package:lawyerapp/components/primarybtn.dart';
import 'package:lawyerapp/components/primaryiconbtn.dart';
import 'package:lawyerapp/components/primarylistview.dart';
import 'package:lawyerapp/components/primarytextfield.dart';
import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:provider/provider.dart';

class Newsscreen extends StatefulWidget {
  bool flag = false;
  @override
  _NewsscreenState createState() => _NewsscreenState();
}

class _NewsscreenState extends State<Newsscreen> {
  String usercase;
  @override
  Widget build(BuildContext context) {
    return Primarylistveiw(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PrimaryIconButton(
              func: () {
                setState(() {
                  widget.flag = !widget.flag;
                });
              },
              icons: widget.flag == false ? Icons.add : Icons.close,
            )
          ],
        ),
        Padding(
          padding: widget.flag == false
              ? EdgeInsets.all(0)
              : EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: widget.flag == false
              ? Container(
                  height: 0,
                  width: 0,
                )
              : Container(
                  decoration: BoxDecoration(
                      color: k_primarycolor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: koldpapper,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Primarytextfield(
                                hint: "Celebrate your Vectory !!",
                                onchange: (val) {
                                  setState(() {
                                    usercase = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Primarybtn(
                              category: "post",
                              expand: () {
                                if (usercase.contains("win") ||
                                    usercase.contains("won") ||
                                    usercase.contains("succeeded")) {
                                  Provider.of<Userprovider>(context,
                                          listen: false)
                                      .addwins();
                                }
                                String documnetID = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                Firestore.instance
                                    .collection('post')
                                    .document(documnetID)
                                    .setData({
                                  "body": usercase,
                                  "user": Provider.of<Userprovider>(context,
                                          listen: false)
                                      .user
                                }).then((_) {
                                  Provider.of<Userprovider>(context,
                                          listen: false)
                                      .addposts();
                                }).catchError((err) {
                                  print(err.toString());
                                  return err;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ),
        ),
        StreamBuilder<dynamic>(
            stream: Firestore.instance.collection("post").snapshots(),
            builder: (context, snapshots) {
              if (snapshots.data == null)
                return Center(
                    child: Theme(
                        data: ThemeData(accentColor: k_primarycolor),
                        child: CircularProgressIndicator()));
              else
                return Column(
                    children: snapshots.data.documents
                        .map<Widget>((e) => Builder(
                              builder: (context) => Newscard(
                                  name: e["user"]["full_name"],
                                  news: e["body"]),
                            ))
                        .toList());
            })
      ],
    );
  }
}
