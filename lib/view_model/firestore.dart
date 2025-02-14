import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<bool> AddNote(String subtitle, String title, int image) async {
    try {

      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

}
