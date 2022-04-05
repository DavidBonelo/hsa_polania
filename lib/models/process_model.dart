import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Process processFromMap(Map<String, dynamic> data) {
  return Process(
    data['expediente'],
    data['status'],
    data['subject'],
    data['asesor'],
    data['lastUpdate']?.toDate(), // converts Timestamp to DateTime
  );
}

class Process {
  final String expediente;
  final String status;
  final String subject;
  final String asesor;
  final DateTime? lastUpdate;
  late final String semaforo; // trafic light

  Process(
      this.expediente, this.status, this.subject, this.asesor, this.lastUpdate)
  //     : semaforo = lastUpdate.difference(DateTime.now()).inDays < -15
  //           ? 'orange'
  //           : 'green';
  {
    // if (lastUpdate != null) {

    final totalDaysSinceUpdate = lastUpdate?.difference(DateTime.now()).inDays;
    // }

    if (status == 'Archived' || status == 'Trasladado') {
      semaforo = 'grey';
    } else if (totalDaysSinceUpdate != null) {
      if (totalDaysSinceUpdate < -30) {
        semaforo = 'red';
      } else if (totalDaysSinceUpdate < -15) {
        semaforo = 'orange';
      } else {
        semaforo = 'green';
      }
    } else {
      semaforo = 'white';
    }
  }

  List<DataCell> getDataCells() {
    final detailsCells = getDetailsMap().values.map((e) {
      e = e is DateTime ? DateFormat('dd-MM-yyyy').format(e) : e;
      return DataCell(Container(
          constraints: const BoxConstraints(maxWidth: 300.0),
          child: Text(
            e.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )));
    }).toList();
    return [
      DataCell(Text(expediente)), ...detailsCells
      // DataCell(Text(semaforo)),
    ];
  }

  Map<String, dynamic> getDetailsMap() {
    return {
      'status': status,
      'subject': subject,
      'asesor': asesor,
      'lastUpdate': lastUpdate,
    };
  }
}

final columnLabels = [
  'Expediente',
  'Estado',
  'Asunto',
  'Asesor',
  'Última actuación'
];

final List<DataColumn> dataColumns = columnLabels
    .map<DataColumn>(
        (e) => DataColumn(label: Text(e, maxLines: 2), onSort: (_, __) {}))
    .toList();
