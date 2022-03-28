import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsa_polania/models/process_model.dart';
// import 'package:flutter/material.dart';

class FirebaseDB {
  // final String documentId;

  // GetUserName(this.documentId);

  final CollectionReference _processes =
      FirebaseFirestore.instance.collection('processes');

  getProcesses() async {
    // final data = await _processes.doc('123').get();
    // print(data.data());
    // print(data.id);
    final data = await _processes.get();
    // print(data.docs);
    for (var dato in data.docs) {
      print(dato.id);
      print(dato.data());
    }
    // print(data);
    // final object = data.data() as Map<String, dynamic>;
    // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
  }

  addProcess(Process process) async {
    _processes.doc(process.expediente).set(process.getDetailsObject());
    // _processes.add({'gg': 1});
  }
}
