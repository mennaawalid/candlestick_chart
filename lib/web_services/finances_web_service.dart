import 'package:fast_csv/fast_csv.dart' as fast_csv;

import '../models/data_model.dart';
import 'package:dio/dio.dart';

class FinancesWebService {
  static Future<List<Data>> getFinances({
    required String interval,
    required int period1,
    required int period2,
  }) async {
    var dio = Dio();

    final response = await dio.get(
      'https://query1.finance.yahoo.com/v7/finance/download/SPUS?period1=$period1&period2=$period2&interval=$interval&events=history&crumb=5YTX%2FgVGBmg',
    );

    final financeData = response.data.toString();
    final rowsAsListOfValues = fast_csv.parse(financeData);

    List<Data> financesList = rowsAsListOfValues
        .skip(1)
        .map(
          (row) => Data(
            date: DateTime.parse(row[0]),
            open: double.parse(row[1]),
            high: double.parse(row[2]),
            low: double.parse(row[3]),
            close: double.parse(row[4]),
            adjClose: double.parse(row[5]),
            volume: int.parse(row[6]),
          ),
        )
        .toList();
    return financesList;
  }
}
