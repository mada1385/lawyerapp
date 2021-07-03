// import 'dart:html';

import 'package:lawyerapp/config/provider.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:lawyerapp/screens/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String useremail;
  User({
    this.city,
    this.area,
    this.address,
    this.ssid,
    this.licencenumber,
    this.lawfield,
    this.name,
    this.phonenumber,
    this.email,
    this.password,
  });

  final String name, address;
  final String email, ssid, licencenumber, lawfield, city, area;

  String id;
  final String phonenumber;
  final String password;
  // final File photo ;
  CollectionReference users = Firestore.instance.collection('lawyer');

  Future<void> addUser(BuildContext context) {
    final user = {
      'full_name': name,
      'email': email,
      'phone_number': phonenumber,
      "photo": null,
      "ssid": ssid,
      "licencenumber": licencenumber,
      "lawfield": lawfield,
      "address": address,
      "city": city,
      "area": area,
      "posts": 0,
      "wins": 0,
      "rate": 0,
      "replies": 0,
      "endoresment": 0,
      "totalrate": 0
    };
    // Call the user's CollectionReference to add a new user
    return users.add(user).then((value) async {
      print("User Added");

      Provider.of<Userprovider>(context).setuser(user);
      Provider.of<Userprovider>(context).setid(value.documentID);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  FirebaseUser currentUser;

  // void loadCurrentUser() {
  //   FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
  //     // call setState to rebuild the view
  //     this.currentUser = user;
  //   });
  // }

  // String getemail() {
  //   loadCurrentUser();
  //   if (currentUser != null) {
  //     return currentUser.email;
  //   } else {
  //     return "no current user";
  //   }
  // }

  Future login(BuildContext context) async {
    String user;
    try {
      final signup = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        user = email;

        print("sucsses");
      }, onError: (error) {
        HapticFeedback.mediumImpact();
        Future.delayed(Duration(milliseconds: 60), () {
          HapticFeedback.mediumImpact();
        });
        print(error.message);

        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: k_primarycolor,
            padding: EdgeInsets.all(0),
            content: Container(
              child: Text(
                error.message,
                style: TextStyle(color: Colors.white),
              ),
            )));
      });
    } catch (e) {
      // user = "failed";
      return e;
    }
    return user;
  }

  Future register(BuildContext context) async {
    String user = "sucsses";

    try {
      final signup = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          useremail = email;
          addUser(context).then((value) {
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: k_primarycolor,
                padding: EdgeInsets.all(10),
                content: Container(
                  child: Text(
                    "An account Created succesfully",
                    style: TextStyle(color: Colors.white),
                  ),
                )));
            // Future.delayed(Duration(seconds: 2), () {
            //   Navigator.pushReplacement(
            //       context, MaterialPageRoute(builder: (context) => Home()));
            // });
          });
        }
      }, onError: (error) {
        HapticFeedback.mediumImpact();
        Future.delayed(Duration(milliseconds: 60), () {
          HapticFeedback.mediumImpact();
        });
        print(error.message);

        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: k_primarycolor,
            padding: EdgeInsets.all(10),
            content: Container(
              child: Text(
                error.message,
                style: TextStyle(color: Colors.white),
              ),
            )));
      });
      return signup;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
