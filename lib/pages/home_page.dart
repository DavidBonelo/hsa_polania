import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HSA Despacho Polania'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('test'),
              _buildTable(),
              ElevatedButton(
                onPressed: () async {
                  final jsonString =
                      await rootBundle.loadString('assets/test.json');
                  final a = jsonDecode(jsonString);
                  print(a);
                },
                child: Icon(Icons.open_in_browser),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable() {
    return GridView(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 5.0),
      children: [
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
        Text('testt'),
      ],
    );
  }
}
