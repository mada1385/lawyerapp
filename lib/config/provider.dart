import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/models/user.dart';

class Userprovider extends ChangeNotifier {
  dynamic user;
  dynamic userid;
  Future<void> getid(BuildContext context, String useremail) async {
    try {
      var messges = await Firestore.instance
          .collection("lawyer")
          .where('email', isEqualTo: useremail)
          .getDocuments();
      for (var massege in messges.documents) {
        user = massege.data;
        userid = massege.reference.documentID;
        break;
      }
      print(userid);
      print(user);
    } catch (e) {}
  }

  setuser(dynamic index) {
    user = index;
    notifyListeners();
  }

  setid(dynamic index) {
    userid = index;
    notifyListeners();
  }

  redorate() async {
    final res =
        await Firestore.instance.collection("lawyer").document(userid).get();
    num posts = res.data["posts"];
    num wins = res.data["wins"];
    num replies = res.data["replies"];
    num endoresment = res.data["endoresment"];
    num rate = res.data["rate"];
    num totalsum =
        rate * .4 + replies * .15 + endoresment * .2 + posts * .05 + wins * .2;
    await Firestore.instance
        .collection("lawyer")
        .document(userid)
        .updateData({"totalrate": totalsum});
  }

  addposts() async {
    final res =
        await Firestore.instance.collection("lawyer").document(userid).get();
    int i = res.data["posts"];
    print(i);
    i++;
    print(i);

    await Firestore.instance
        .collection("lawyer")
        .document(userid)
        .updateData({"posts": i});
    redorate();
  }
  //   addwins() async {

  //   final res =
  //       await Firestore.instance.collection("lawyer").document(userid).get();
  //   int i = res.data["wins"];
  //   print(i);
  //   i++;
  //   print(i);

  //   await Firestore.instance
  //       .collection("lawyer")
  //       .document(userid)
  //       .updateData({"wins": i});
  //   redorate();
  // }

  addwins() async {
    final res =
        await Firestore.instance.collection("lawyer").document(userid).get();
    int i = res.data["wins"];
    i++;
    await Firestore.instance
        .collection("lawyer")
        .document(userid)
        .updateData({"wins": i});
    redorate();
  }

  addreplies() async {
    final res =
        await Firestore.instance.collection("lawyer").document(userid).get();
    int i = res.data["replies"];
    i++;
    await Firestore.instance
        .collection("lawyer")
        .document(userid)
        .updateData({"replies": i});
    redorate();
  }

  addendoresment() async {
    final res =
        await Firestore.instance.collection("lawyer").document(userid).get();
    int i = res.data["endoresment"];
    i++;
    await Firestore.instance
        .collection("lawyer")
        .document(userid)
        .updateData({"endoresment": i});
    redorate();
  }
}
