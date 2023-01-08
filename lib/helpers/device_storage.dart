// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:path_provider/path_provider.dart';

// Project imports:

class DeviceStorage {
  String fileName = "data";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<void> storeData(Map<String, dynamic> data) async {
    final file = await _localFile;
    final String json = jsonEncode(data);
    file.writeAsStringSync(json);
  }

  Future<Map<String, dynamic>> readData() async {
    Map<String, dynamic> returnData = {};
    final file = await _localFile;
    if (await file.exists()) {
      final String json = file.readAsStringSync();
      final Map<String, dynamic> data = jsonDecode(json);
      return data;
    }
    return returnData;
  }

  Future deleteAllData() async {
    final file = await _localFile;
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}
