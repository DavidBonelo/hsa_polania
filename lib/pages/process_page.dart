import 'package:flutter/material.dart';

import '../models/process_model.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({Key? key, required this.process}) : super(key: key);

  final Process process;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proceso ${process.expediente}'),
      ),
      body: Center(
        // child: SingleChildScrollView(
        child: ProcessDetails(process: process),
        // ),
      ),
    );
  }
}

class ProcessDetails extends StatelessWidget {
  const ProcessDetails({
    Key? key,
    required this.process,
  }) : super(key: key);

  final Process process;

  @override
  Widget build(BuildContext context) {
    final details = process.getDetailsMap();
    final itemsList = [
      Text('Expediente: ${process.expediente}', textAlign: TextAlign.center)
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return Text(
          '${columnLabels[i + 1]}: ${details.values.toList()[i]}',
          textAlign: TextAlign.center,
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: details.length, // + expediente
    );
  }
}
