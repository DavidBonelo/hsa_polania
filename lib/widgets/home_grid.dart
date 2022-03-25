import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key, required this.data}) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    // data.map((e)=>Container()).toList();
    final List<Widget> items = [];
    for (var row in data) {
      items.addAll([Text(row['expediente'].toString()), Text(row['status'])]);
    }
    return GridView(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 5.0),
      children: items,
    );
  }
}
