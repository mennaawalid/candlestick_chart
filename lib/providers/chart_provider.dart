import 'package:flutter/material.dart';

import '../models/data_model.dart';
import '../web_services/finances_web_service.dart';

class ChartProvider with ChangeNotifier {
  List<Data> _list = [];

  Future<List<Data>> getList() async {
    _list = await FinancesWebService.getFinances(
      interval: intervalValue,
      period1: fromDateInEpoch,
      period2: toDateInEpoch,
    );
    return _list;
  }

  var isButtonClicked = false;

  void setButtonClick() {
    isButtonClicked = true;
    notifyListeners();
  }

  String _intervalValue = '';
  int _dropDownvalue = 1;
  DateTime? _fromDate;
  DateTime? _toDate;

  void setFromDate(DateTime from) {
    _fromDate = from;
    notifyListeners();
  }

  void setToDate(DateTime to) {
    _toDate = to;
    notifyListeners();
  }

  DateTime? get fromDate {
    return _fromDate;
  }

  DateTime? get toDate {
    return _toDate;
  }

  int get fromDateInEpoch {
    double date = fromDate!.millisecondsSinceEpoch / 1000;
    return date.toInt();
  }

  int get toDateInEpoch {
    double date = toDate!.millisecondsSinceEpoch / 1000;
    return date.toInt();
  }

  void setIntervalValue(String value) {
    _intervalValue = value;
    notifyListeners();
  }

  String get intervalValue {
    return _intervalValue;
  }

  void setDropDownvalue(int val) {
    _dropDownvalue = val;
    notifyListeners();
  }

  int get dropDownvalue {
    return _dropDownvalue;
  }
}
