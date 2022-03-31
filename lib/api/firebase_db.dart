import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hsa_polania/models/process_model.dart';
// import 'package:flutter/material.dart';

class FirebaseDB {
  // final String documentId;

  // GetUserName(this.documentId);

  final CollectionReference _processes =
      FirebaseFirestore.instance.collection('processes');

  Future<List<Process>> getProcesses() async {
    // final data = await _processes.doc('123').get();
    // print(data.data());
    // print(data.id);
    final data = await _processes.get();

    // for (var element in data.docs) {
    //   print(element.id);
    // }

    final List<Process> processList = [];
    // print(data.docs);
    for (var dato in data.docs) {
      final data = dato.data() as Map<String, dynamic>;
      var actuationsQuery = await dato.reference
          .collection('modificaciones')
          .orderBy('fecha')
          // .limitToLast(1)
          .get();
      final actuationsList = actuationsQuery.docs;
      for (var actuation in actuationsList) {
        print(actuation.data());
      }
      // if (actuationsList.isNotEmpty) print(actuationsList.last.data());
      // print(actuationsList.isNotEmpty ? actuationsList.last.data() : null);
      data.addAll({'expediente': dato.id});
      processList.add(processFromMap(data));
      // print(dato.id);
      // print(dato.data());
    }
    // print(data);
    // final object = data.data() as Map<String, dynamic>;
    // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
    // print(processList);
    return processList;
  }

  addProcess(Process process) async {
    _processes.doc(process.expediente).set(process.getDetailsObject());
    // _processes.add({'gg': 1});
  }

  Object? getActuations() {}
}
