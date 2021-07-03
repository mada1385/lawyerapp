import 'package:flutter/material.dart';
import 'package:lawyerapp/components/circleavatar.dart';
import 'package:lawyerapp/components/readmore.dart';
import 'package:lawyerapp/constants/colours.dart';

class Commentfield extends StatelessWidget {
  final dynamic e;
  const Commentfield({this.e});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Goldcircleavatar(size: 50),
                  ),
                  Text(e["user"]["full_name"])
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  child: ReadMoreText(
                    e["reply"],
                    colorClickableText: k_primarycolor,
                    trimLength: 100,
                    trimLines: 2,
                  )),
            ],
          ),
        ));
  }
}
