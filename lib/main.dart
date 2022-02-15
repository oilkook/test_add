import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:test_app/actions/action_sheet.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/view/home.dart';

void main() async {
  // final gsheet = GSheets(Config.credentials);
  // final sheet = await gsheet.spreadsheet(Config.spreadsheetId);
  // final res = await sheet.worksheetByTitle('User').values.allRows();
  // print(res);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
