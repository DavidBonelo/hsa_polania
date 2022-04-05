import 'package:flutter/material.dart';

class HomeTable extends StatelessWidget {
  const HomeTable({Key? key, required this.data}) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    final tableColumns = TableRow(
        children: data[0]
            .keys
            .map<Text>((e) => Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                ))
            .toList());
    final tableItems = data.map<TableRow>((e) {
      final List<Text> rowItems = e.values
          .map<Text>((e) => Text(
                e.toString(),
                textAlign: TextAlign.center,
              ))
          .toList();
      return TableRow(
        decoration: getStatusColor(rowItems[1].data),
        children: [...rowItems],
      );
    }).toList();
    // data.map((e)=>Container()).toList();
    // final List<Widget> items = [];
    // for (var row in data) {
    //   items.addAll([Text(row['expediente'].toString()), Text(row['status'])]);
    // }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(200),
          // defaultColumnWidth: FlexColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          children: [tableColumns, ...tableItems],
          // children: [TableRowInkWell()], // doesn't work
        ),
      ),
    );
  }
}

getStatusColor(String? status) {
  switch (status) {
    case 'active':
      return const BoxDecoration(color: Colors.green);
    case 'archived':
      return const BoxDecoration(color: Colors.orange);
    default:
      return null;
  }
}
