import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/logs.dart';
import 'package:intl/intl.dart';
import 'package:Stock/Widgets/summary.dart';

class OrderHistory extends StatefulWidget {
  String id;
  OrderHistory(this.id);
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Logs>(context).fetchAndSetProducts(widget.id).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<Logs>(context, listen: false);
    final history = logs.history;
    final rctlist = logs.recentTransactions;
    final dayrctlist = logs.dayrecentTransactions;
    final monthrctlist = logs.monthrecentTransactions;

    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        Summary(history, rctlist, dayrctlist, monthrctlist)));
              })
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xFFEEF5DB),
              child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFB8D8D8)),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              history[i].name,
                              style: TextStyle(
                                  color: history[i].happn == 'added'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(history[i].time),
                              style: TextStyle(
                                  color: history[i].happn == 'added'
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            SizedBox(
                              height: 9,
                            )
                          ],
                        ),
                        trailing: Container(
                          width: 115,
                          child: Row(
                            children: [
                              Text(
                                history[i].happn,
                                style: TextStyle(
                                    color: history[i].happn == 'added'
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                history[i].amount.toString(),
                                style: TextStyle(
                                    color: history[i].happn == 'added'
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
