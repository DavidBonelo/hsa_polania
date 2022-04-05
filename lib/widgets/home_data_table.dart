import 'package:flutter/material.dart';
import 'package:hsa_polania/models/process_model.dart';
import 'package:hsa_polania/pages/process_page.dart';

class HomeDataTable extends StatelessWidget {
  const HomeDataTable({Key? key, required this.data}) : super(key: key);

  final List<Process> data;

  @override
  Widget build(BuildContext context) {
    // final testDataRows = [
    //   DataRow(
    //     onSelectChanged: (_) {
    //       goToProcess(testProcess, context);
    //     },
    //     cells: testProcess.getDataCells(),
    //   ),
    // ];

    // final testDataRows = testProcessList.map((element) {
    final testDataRows = data.map((element) {
      return DataRow(
        onSelectChanged: (_) {
          goToProcess(element, context);
          print(element.lastUpdate);
        },
        cells: element.getDataCells(),
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          // return Colors.green; // Use the default value.
          return getSemaforoColor(element.semaforo); // Use the default value.
        }),
      );
    }).toList();

    //
//     final tableColumns = data[0]
//         .keys
//         .map<DataColumn>(
//           (e) => DataColumn(
//               label: Text(
//             e.toString(),
//             // textAlign: TextAlign.center,
//           )),
//         )
//         .toList();
//     final tableItems = data.map<DataRow>((e) {
//       final List<DataCell> rowItems = e.values
//           .map<DataCell>((e) => DataCell(Text(
//                 e.toString(),
//                 // textAlign: TextAlign.center,
//               )))
//           .toList();
//       return DataRow(
//           onSelectChanged: (_) {
// // need ne id here somehow
//             Navigator.push<void>(
//                 context,
//                 MaterialPageRoute<void>(
//                   builder: (context) => ProcessPage(
//                     processId: '69420',
//                   ),
//                 ));
//           },
//           // decoration: getStatusColor(rowItems[1].child.data),
//           cells: rowItems,
//           color: MaterialStateProperty.resolveWith<Color?>(
//               (Set<MaterialState> states) {
//             if (states.contains(MaterialState.selected)) return Colors.orange;
//             // return Theme.of(context).colorScheme.primary.withOpacity(0.08);
//             // return Colors.green; // Use the default value.
//             return null; // Use the default value.
//           }));
//     }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: dataColumns,
          rows: testDataRows,

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

  goToProcess(Process process, BuildContext context) {
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ProcessPage(
            process: process,
          ),
        ));
  }
}

Color? getSemaforoColor(String? status) {
  switch (status) {
    case 'green':
      // return const BoxDecoration(color: Colors.green);
      return Colors.green.withOpacity(0.5);
    case 'red':
      // return const BoxDecoration(color: Colors.orange);
      return Colors.red.withOpacity(0.5);
    case 'orange':
      return Colors.orange.withOpacity(0.5);
    case 'grey':
      return Colors.grey.withOpacity(0.5);
    default:
      return null;
  }
}
