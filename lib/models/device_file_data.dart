import 'package:expense_controller/models/transaction.dart';

class DeviceFileData {
  List<Transaction>? transactions;
  int? theme;

  DeviceFileData({
    required this.transactions,
    this.theme = 0,
  });

  DeviceFileData.fromJson(Map<String, dynamic> json) {
    transactions = json["transactions"];
    theme = json["theme"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["transactions"] = transactions;
    data["theme"] = theme;

    return data;
  }
}
