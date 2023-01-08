import 'package:expense_controller/helpers/device_storage.dart';
import 'package:expense_controller/models/device_file_data.dart';
import 'package:expense_controller/models/transaction.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

part './screen_controller.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final ScreenController _controller = ScreenController();
  bool isLoading = true;
  late List<Transaction> transactions;

  Future<void> _getTransactions() async {
    DeviceFileData data = await _controller.getDeviceData();

    transactions = data.transactions!;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    if (mounted) {
      _getTransactions();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: offWhite,
        body: Center(
            child: SizedBox(
          height: 200,
          child: Image.asset(
            "assets/images/icon.png",
            fit: BoxFit.cover,
          ),
        )),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: marginPaddingOnly(bottom: 40),
              child: isLoading
                  ? Text(
                      "Aguarde...",
                      style: textBoldPrimary(context: context, size: 25),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(5),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            marginPaddingOnly(
                                top: 5, bottom: 5, left: 15, right: 15)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home", (route) => false,
                            arguments: {
                              "transactions": transactions,
                            });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Continuar",
                              style: textBoldWhite(size: 20),
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
