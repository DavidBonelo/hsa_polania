import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hsa_polania/api/firebase_db.dart';
import 'package:hsa_polania/models/process_model.dart';
import 'package:hsa_polania/widgets/add_user_test.dart';
import 'package:hsa_polania/widgets/home_grid.dart';
import 'package:hsa_polania/widgets/home_table.dart';
import 'package:hsa_polania/widgets/read_user.dart';

import '../widgets/home_data_table.dart';

final firebaseProvider = Provider<FirebaseDB>((ref) {
  return FirebaseDB();
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(firebaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HSA Despacho Polania'),
        actions: [
          IconButton(
            onPressed: () => db.getProcesses(),
            icon: const Icon(Icons.sync),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // AddUser('xdd', 'aaaa', 21),
              // GetUserName('asdfgh'),
              const Text('test'),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data!);
                    // return HomeGrid(data: snapshot.data!);
                    return HomeDataTable(data: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }

  // Widget _buildTable() {
  //   return
  // }

  Future<List> getData() async {
    final jsonString = await rootBundle.loadString('assets/test.json');
    final a = jsonDecode(jsonString);
    // print(a);
    final List ee = a['processes'];
    return ee;
  }
}
