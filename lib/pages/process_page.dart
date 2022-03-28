import 'package:flutter/material.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({Key? key, required this.processId}) : super(key: key);

  final String processId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proceso $processId'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text('Detalles del proceso $processId'),
        ),
      ),
    );
  }
}
