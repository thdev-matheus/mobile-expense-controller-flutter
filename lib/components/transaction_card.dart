import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.onAction,
    required this.valueText,
    required this.trTitle,
    required this.trSubTitle,
  });

  final void Function() onAction;
  final String valueText;
  final String trTitle;
  final String trSubTitle;

  String formatBrDate() {
    List<String> dateSplit = trSubTitle.split(" ");

    switch (dateSplit[1]) {
      case "Jan":
        dateSplit[1] = "Jan";
        break;
      case "Feb":
        dateSplit[1] = "Fev";
        break;
      case "Mar":
        dateSplit[1] = "Mar";
        break;
      case "Apr":
        dateSplit[1] = "Abr";
        break;
      case "May":
        dateSplit[1] = "Mai";
        break;
      case "Jun":
        dateSplit[1] = "Jun";
        break;
      case "Jul":
        dateSplit[1] = "Jul";
        break;
      case "Aug":
        dateSplit[1] = "Ago";
        break;
      case "Sep":
        dateSplit[1] = "Set";
        break;
      case "Oct":
        dateSplit[1] = "Out";
        break;
      case "Nov":
        dateSplit[1] = "Nov";
        break;
      case "Dec":
        dateSplit[1] = "Dez";
        break;
    }

    return dateSplit.join(" ");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        margin: marginPaddingAll(size: 5),
        child: Padding(
          padding: marginPaddingSymetric(vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    valueText,
                    style: textBoldSecondary(context: context, size: 12),
                  ),
                ),
              ),
            ),
            title: Text(
              trTitle,
              style: textBoldGray(size: 16),
            ),
            subtitle: Text(formatBrDate()),
            trailing: MediaQuery.of(context).size.width > 480
                ? ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    label: Text(
                      "Excluir",
                      style: textBoldSecondary(
                        context: context,
                        size: 18,
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: onAction,
                  ),
          ),
        ),
      ),
    );
  }
}
