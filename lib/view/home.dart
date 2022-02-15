import 'package:flutter/material.dart';
import 'package:test_app/actions/action_sheet.dart';
import 'package:test_app/models/order.dart';
import 'package:test_app/view/order_detail.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoad = true;
  List<Order> orders = [];
  List<Order> pendingOrders = [];
  List<Order> deleteOrders = [];
  List<Widget> page = [];
  initialAction() async {
    final res = await ActionSheet.getAll();
    print(res);

    final pending = res.where((element) => element.status == "0").toList();
    final complete = res.where((element) => element.status == "2").toList();
    final delete = res.where((element) => element.status == "4").toList();
    setState(() {
      orders = complete;
      pendingOrders = pending;
      deleteOrders = delete;
    });
  }

  @override
  void initState() {
    super.initState();
    initialAction();
  }

  GestureDetector orderCard(Order payload) {
    String statusText = "";
    switch (payload.status) {
      case "0":
        statusText = "รอยืนยัน";
        break;
      case "1":
        statusText = "กำลังซ่อม";
        break;
      case "2":
        statusText = "ยืนยันแล้ว";
        break;
      case "3":
        statusText = "ยกเลิก";
        break;
      case "4":
        statusText = "ลบ";
        break;
      default:
        statusText = "Error";
    }

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetail(
                payload: payload,
              ),
            ));

        initialAction();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                payload.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              )),
              Text(
                '$statusText',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              // Text('${payload.status}'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Repair Test'),
            bottom: TabBar(tabs: [
              GestureDetector(
                child: Tab(text: 'ใบแจ้งซ่อม'),
                onTap: () => initialAction(),
              ),
              GestureDetector(
                child: Tab(
                  text: 'รายการเข้าซ่อม',
                ),
                onTap: () => initialAction(),
              )
            ]),
          ),
          body: TabBarView(
            children: [
              pendingOrders.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: pendingOrders.length,
                      itemBuilder: (context, index) =>
                          orderCard(pendingOrders[index]),
                    )
                  : Container(
                      child: Text(" No Order "),
                    ),
              orders.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) => orderCard(orders[index]),
                    )
                  : Container(
                      child: Text(" No Order "),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
