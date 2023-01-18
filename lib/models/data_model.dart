class Data {
  final DateTime date;
  final double close;
  final double adjClose;
  final double open;
  final double low;
  final double high;
  final int volume;

  Data({
    required this.date,
    required this.close,
    required this.adjClose,
    required this.open,
    required this.low,
    required this.high,
    required this.volume,
  });
}
