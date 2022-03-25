import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hsa_polania/widgets/add_user_test.dart';
import 'package:hsa_polania/widgets/home_grid.dart';
import 'package:hsa_polania/widgets/home_table.dart';
import 'package:hsa_polania/widgets/read_user.dart';

import '../widgets/home_data_table.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddUser('xdd', 'aaaa', 21),
              GetUserName('asdfgh'),
              const Text('test'),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!);
                    // return HomeGrid(data: snapshot.data!);
                    return HomeDataTable(data: snapshot.data!);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTable() {
  //   return
  // }

  Future<List> getData() async {
    final jsonString = await rootBundle.loadString('assets/test.json');
    // final a = json.decode(jsonString);
    final a = jsonDecode(jsonString);
    print(a);
    final List ee = a['processes'];
    return ee;
  }
}
