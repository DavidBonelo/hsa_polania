import 'dart:convert';
import 'dart:html' as http;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
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

  uploadProcesses() async {
    final CollectionReference _activeProcesses =
        FirebaseFirestore.instance.collection('active-processes-test');

    var fields = [];

    if (kIsWeb) {
      var request = await http.HttpRequest.request(
        // 'https://raw.githubusercontent.com/DavidBonelo/hsa_polania/main/data/hsa_active.csv',
        'data/hsa_active.csv',
      );
      fields = const CsvToListConverter().convert(request.response);
    } else {
      final input = File('data/hsa_active.csv').openRead();
      fields = await input // List<List<dynamic>>
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();
    }

    // skips first row (column names)
    // for (var i = 1; i < fields.length; i++) {
    for (var i = 1; i < 5; i++) {
      var date = DateTime.tryParse(fields[i][13]);
      date ??= DateTime.tryParse(fields[i][25]);
      if (date == null) print('invalid date at $i');

      final Map<String, dynamic> processDetails = {
        'TIPO REPARTO': fields[i][1],
        'PONENTE': fields[i][2],
        'FECHA DE RADICADO AL CNE': fields[i][3],
        'FECHA DE REPARTO': fields[i][4],
        'ASUNTO': fields[i][5],
        'DEPARTAMENTO': fields[i][6],
        'MUNICIPIO': fields[i][7],
        'SOLICITANTE': fields[i][8],
        'REFERENCIA': fields[i][9],
        'ASESOR': fields[i][10],
        'ESTADO': fields[i][11],
        'SUBESTADO': fields[i][12],
        'FECHA ULTIMA ACTUACION': date,
        'DETALLE ULTIMA ACTUACION': fields[i][14],
        'ADJUNTO ULTIMA ACTUACION': '',
        // duplicar ultima actualización
        'TIEMPO EN ESTADO (SEMAFORO) NO DILIGENCIAR': fields[i][15],
        'FECHA HECHO GENERADOR': fields[i][16],
        'FECHA ACTUAL': fields[i][17],
        'DIAS DESDE EL RADICADO (NO DILIGENCIAR)': fields[i][18],
        'FECHA DE CADUCIDAD': fields[i][19],
        'VALIDADO DESPACHO': fields[i][20],
        'ACCION SUBSECRETARIA': fields[i][21],
        'Otros comentarios': fields[i][22],
        'Otros comentarioss': fields[i][23],
        'FECHA CADUCIDAD': fields[i][24],
      };
      _activeProcesses.doc(fields[i][0]).set(processDetails);
    }
  }
}
