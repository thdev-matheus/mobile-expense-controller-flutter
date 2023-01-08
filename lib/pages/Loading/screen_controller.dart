part of "./loading_page.dart";

class ScreenController {
  final DeviceStorage device = DeviceStorage();

  Future<DeviceFileData> getDeviceData() async {
    DeviceFileData data = await device.readData().then((value) {
      List<Transaction> transactions = <Transaction>[];

      if (value["transactions"] != null) {
        transactions = [
          ...value["transactions"].map((e) => Transaction.fromJson(e))
        ];
      }

      Map<String, dynamic> json = {
        "transactions": transactions,
      };

      return DeviceFileData.fromJson(json);
    });

    return data;
  }
}

// part of "./loading_page.dart";

// class ScreenController {
//   final DeviceStorage device = DeviceStorage();

//   Future<DeviceFileData> getDeviceData() async {
//     DeviceFileData data =
//         await device.readData().then((value) => DeviceFileData.fromJson(value));

//     return data;
//   }
// }
