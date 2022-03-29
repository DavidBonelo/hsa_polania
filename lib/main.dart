import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hsa_polania/firebase_options.dart';
import 'package:hsa_polania/models/process_model.dart';
import 'package:hsa_polania/pages/home_page.dart';
import 'package:hsa_polania/pages/process_page.dart';

import 'api/firebase_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HSA Polania',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      // home: ProcessPage(process: testProcess),
    );
  }
}
