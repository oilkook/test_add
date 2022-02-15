import 'package:flutter/material.dart';
import 'package:test_app/actions/action_sheet.dart';
import 'package:test_app/models/order.dart';

class OrderDetail extends StatelessWidget {
  final Order payload;
  const OrderDetail({Key key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Card(
            child: Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ชื่อ : ${payload.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'ห้อง : ${payload.dormitory}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'หอ : ${payload.room}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  // Text('${payload.status}'),
                  Spacer(),
                  RaisedButton(
                    onPressed: () async {
                      await ActionSheet.editStatus(
                          order: Order(
                              id: payload.id,
                              name: payload.name,
                              dormitory: payload.dormitory,
                              room: payload.room),
                          status: "2");

                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                    color: Colors.green,
                  ),

                  RaisedButton(
                    onPressed: () async {
                      await ActionSheet.editStatus(
                          order: Order(
                              id: payload.id,
                              name: payload.name,
                              dormitory: payload.dormitory,
                              room: payload.room),
                          status: "4");

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
