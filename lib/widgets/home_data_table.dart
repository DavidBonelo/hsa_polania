import 'package:flutter/material.dart';

class HomeDataTable extends StatelessWidget {
  const HomeDataTable({Key? key, required this.data}) : super(key: key);

  final List data;

  @override
  Widget build(BuildContext context) {
    final tableColumns = data[0]
        .keys
        .map<DataColumn>(
          (e) => DataColumn(
              label: Text(
            e.toString(),
            // textAlign: TextAlign.center,
          )),
        )
        .toList();
    final tableItems = data.map<DataRow>((e) {
      final List<DataCell> rowItems = e.values
          .map<DataCell>((e) => DataCell(Text(
                e.toString(),
                // textAlign: TextAlign.center,
              )))
          .toList();
      return DataRow(
          onSelectChanged: (_) {},
          // decoration: getStatusColor(rowItems[1].child.data),
          cells: rowItems,
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) return Colors.orange;
            // return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            // return Colors.green; // Use the default value.
            return null; // Use the default value.
          }));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: tableColumns,
          rows: tableItems,
          border: TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
          // children: [TableRowInkWell()], // doesn't work
          sortAscending: true,
          sortColumnIndex: 0,
          // onSelectAll: (_) {},
          showCheckboxColumn: false,
        ),
      ),
    );
  }
}

Color? getStatusColor(String? status) {
  switch (status) {
    case 'active':
      // return const BoxDecoration(color: Colors.green);
      return Colors.green;
    case 'archived':
      // return const BoxDecoration(color: Colors.orange);
      return Colors.orange;
    default:
      return null;
  }
}
