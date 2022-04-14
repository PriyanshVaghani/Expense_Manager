import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  Map<String, double> dataMap = {
    "food": 5000,
    "entertainment": 1000,
    "Finance": 4000,
    "Shopping": 3000,
  };

  Chart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chart of your Expense",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 8, 6, 90),
          //brightness: Brightness.dark,
        ),
        body: Center(
            child: PieChart(
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
        )));
  }
}


// import 'package:flutter/material.dart';

// class PieChart extends StatefulWidget {
//   const PieChart({Key? key}) : super(key: key);

//   @override
//   _PieChartState createState() => _PieChartState();
// }

// class _PieChartState extends State<PieChart> {
//   var type = 0;
//   bool value = true;

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Charts'),
//         // child: Row(
//         //   children: [
//         //     Radio(
//         //         value: 1,
//         //         groupValue: type,
//         //         onChanged: (value) {
//         //           setState(() {
//         //             type = value as int;
//         //           });
//         //         }),
//         //     const Text('Income'),
//         //     Radio(
//         //         value: 2,
//         //         groupValue: type,
//         //         onChanged: (value) {
//         //           setState(() {
//         //             type = value as int;
//         //           });
//         //         }),
//         //     const Text('Expence'),
//         //     Transform.scale(
//         //       scale: 2,
//         //       child: Switch.adaptive(
//         //           value: value,
//         //           onChanged: (value) {
//         //             setState(() {
//         //               this.value = value;
//         //             });
//         //           }),
//         //     )
//         //   ],
//         // ),
//       ),
//       // Center(child: Text('Pia chart'),),
//     );
//   }
// }
