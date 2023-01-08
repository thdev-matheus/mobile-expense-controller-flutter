class Transaction {
  String? id;
  String? title;
  double? value;
  String? date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    value = json["value"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["id"] = id;
    data["title"] = title;
    data["value"] = value;
    data["date"] = date;

    return data;
  }
}
