import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/data_model.dart';
import '../providers/chart_provider.dart';

class FinacesChartScreen extends StatelessWidget {
  const FinacesChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ChartProvider>(context);

    void showFirstFromDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 12, 18),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        dataProvider.setFromDate(pickedDate!);
      });
    }

    void showSecondToDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 12, 19),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        dataProvider.setToDate(pickedDate!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chart',
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Choose the interval",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              DropdownButton(
                isExpanded: false,
                value: dataProvider.dropDownvalue,
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text("1 day"),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text("1 week"),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text("1 month"),
                  )
                ],
                onChanged: (int? value) {
                  if (value == 1) {
                    dataProvider.setIntervalValue('1d');
                  } else if (value == 2) {
                    dataProvider.setIntervalValue('1wk');
                  } else {
                    dataProvider.setIntervalValue('1mo');
                  }
                  dataProvider.setDropDownvalue(value!);
                },
                hint: const Text("available intervals"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  showFirstFromDatePicker();
                },
                child: const Text('Pick Start Date'),
              ),
              Text(
                dataProvider.fromDate == null
                    ? 'No Date Chosen'
                    : 'Picked Date: ${DateFormat.yMd().format(dataProvider.fromDate!)}',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  showSecondToDatePicker();
                },
                child: const Text('Pick End Date'),
              ),
              Text(
                dataProvider.toDate == null
                    ? 'No Date Chosen'
                    : 'Picked Date: ${DateFormat.yMd().format(dataProvider.toDate!)}',
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await dataProvider.getList();
              dataProvider.setButtonClick();
            },
            child: const Text('get chart'),
          ),
          dataProvider.isButtonClicked
              ? FutureBuilder(
                  future: dataProvider.getList(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : !snapshot.hasData
                              ? const Text("there's no stocks")
                              : SafeArea(
                                  child: SfCartesianChart(
                                    series: <CandleSeries>[
                                      CandleSeries<Data, DateTime>(
                                        dataSource: snapshot.data!,
                                        xValueMapper: (Data data, index) =>
                                            data.date,
                                        lowValueMapper: (Data data, index) =>
                                            data.low,
                                        highValueMapper: (Data data, index) =>
                                            data.high,
                                        openValueMapper: (Data data, index) =>
                                            data.open,
                                        closeValueMapper: (Data data, index) =>
                                            data.close,
                                      ),
                                    ],
                                    primaryXAxis: DateTimeAxis(),
                                  ),
                                ),
                  // : Column(
                  //     children: [
                  //       Text(
                  //         snapshot.data![0].date.toString(),
                  //       ),
                  //       Text(
                  //         snapshot
                  //             .data![snapshot.data!.length - 1].date
                  //             .toString(),
                  //       ),
                  //     ],
                  //   ),
                )
              : Container(),
        ],
      ),
    );
  }
}
