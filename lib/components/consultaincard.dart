import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/commentfield.dart';
import 'package:lawyerapp/components/commenttextfield.dart';
import 'package:lawyerapp/components/readmore.dart';
import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/constants/decoration.dart';
import 'package:provider/provider.dart';

import 'circleavatar.dart';

class Consultaioncard extends StatelessWidget {
  const Consultaioncard({
    this.firstbuttonhight = false,
    this.concult,
    this.username,
    this.replies,
    this.refrence,
  });
  final String refrence;
  final List replies;
  final bool firstbuttonhight;
  final String concult, username;

  @override
  Widget build(BuildContext context) {
    return firstbuttonhight == false
        ? Container(
            height: 0,
            width: 0,
          )
        : GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Sendreply(refrence: refrence));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Goldcircleavatar(
                          size: 60,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                            child: Container(
                          child: Text(username),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: k_primarycolor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Colors.transparent,
                        child: ReadMoreText(
                          concult,
                          colorClickableText: k_primarycolor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: replies == null
                              ? []
                              : replies
                                  .map<Widget>((e) => Builder(
                                        builder: (context) => Commentfield(
                                          e: e,
                                        ),
                                      ))
                                  .toList()),
                    )
                  ],
                ),
                width: double.infinity,
                decoration: kdecorationconsultaion,
              ),
            ),
          );
  }
}

class Sendreply extends StatelessWidget {
  final replycontroller = TextEditingController();
  final String refrence;

  Sendreply({Key key, this.refrence}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // height: 200,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(30.0),
                //     topRight: Radius.circular(30.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 41,
                                width: 140,
                                child: CommentCustomTextfield(
                                  autofoucs: true,
                                  controller: replycontroller,
                                  validator: 0,
                                  hint: "Add A Reply",
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 20,
                            color: k_primarycolor,
                          ),
                          onPressed: () async {
                            Firestore.instance
                                .collection("cases")
                                .document(refrence)
                                .updateData({
                              "replies": FieldValue.arrayUnion([
                                {
                                  "user": Provider.of<Userprovider>(context,
                                          listen: false)
                                      .user,
                                  "reply": replycontroller.text,
                                  "endoresment": 0,
                                  "time": DateTime.now().toString(),
                                  "lawyerid": Provider.of<Userprovider>(context,
                                          listen: false)
                                      .userid,
                                }
                              ])
                            }).then((value) => Provider.of<Userprovider>(
                                        context,
                                        listen: false)
                                    .addreplies());
                          })
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Container(
                  //   width: 304,
                  //   height: 1,
                  //   color: Color(0xffEEEEEE),
                  // ),
                ],
              ),
            )));
  }
}
