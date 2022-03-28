import 'package:flutter/material.dart';

class Process {
  final String expediente;
  final String status;
  final String subject;
  final String asesor;
  final DateTime lastUpdate;
  final String semaforo;

  Process(
      this.expediente, this.status, this.subject, this.asesor, this.lastUpdate)
      : semaforo = lastUpdate.difference(DateTime.now()).inDays < -15
            ? 'red'
            : 'green';
  //            {
  //   print(lastUpdate.difference(DateTime.now()).inDays);
  // }

  List<DataCell> getDataCells() {
    return [
      DataCell(Text(expediente)),
      DataCell(Text(status)),
      DataCell(Text(subject)),
      DataCell(Text(asesor)),
      DataCell(Text(lastUpdate.toString())),
      // DataCell(Text(semaforo)),
    ];
  }

  Object getDetailsObject() {
    return {
      'status': status,
      'subject': subject,
      'asesor': asesor,
      'lastUpdate': lastUpdate,
    };
  }
}

const columnLabels = [
  DataColumn(label: Text('Expediente')),
  DataColumn(label: Text('Estado')),
  DataColumn(label: Text('Asunto')),
  DataColumn(label: Text('Asesor')),
  DataColumn(label: Text('Última modificación')),
  // DataColumn(label: Text('semaforo')),
];

Process testProcess = Process(
  '123',
  'Active',
  'subject asdf',
  'Maria',
  DateTime.now(),
);
List<Process> testProcessList = [
  Process(
    '123',
    'Active',
    'subject asdf',
    'Maria',
    DateTime.now(),
  ),
  Process(
    '1234',
    'Archived',
    'subject afdssdf',
    'Shane',
    DateTime.now().subtract(const Duration(days: 20)),
  ),
  Process(
    '123asfd4',
    'Archived',
    'subjeafsdct afdssdf',
    'Shaneaa',
    DateTime.now().subtract(const Duration(days: 30)),
  ),
  Process(
    'aasfd4',
    'Active',
    'subjea',
    'me',
    DateTime.now().subtract(const Duration(days: 4)),
  ),
];
