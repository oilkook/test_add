import 'package:gsheets/gsheets.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/models/order.dart';

class ActionSheet {
  static Future<List<Order>> getAll() async {
    final gsheets = GSheets(Config.credentials);

    final sheet = await gsheets.spreadsheet(Config.spreadsheetId);

    final res = await sheet.worksheetByTitle('User').values.allRows();
    // print(res[1][1]);
    return List.generate(
        res.length - 1,
        (index) => Order(
            // [row][col]
            id: res[index + 1][0],
            name: res[index + 1][1],
            room: res[index + 1][2],
            dormitory: res[index + 1][3],
            status: res[index + 1][4]));
  }

  static getRequestById(int order_id) async {
    final gsheets = GSheets(Config.credentials);
    final sheet = await gsheets.spreadsheet(Config.spreadsheetId);
    final res = await sheet
        .worksheetByTitle('Order')
        .values
        .rowByKey(order_id, fromColumn: 1);

    // return Order(
    //   id: int.parse(res[1]),
    //   name: res[2],
    //   room: res[3],
    //   dormitory: res[4],
    //   status: int.parse(res[5]),
    // );
  }

  static editStatus({Order order, String status}) async {
    final gsheets = GSheets(Config.credentials);
    final sheet = await gsheets.spreadsheet(Config.spreadsheetId);
    final res =
        await sheet.worksheetByTitle('User').values.insertRowByKey(order.id, [
      order.name,
      order.room,
      order.dormitory,
      status,
    ]);

    print(res);
  }
}
