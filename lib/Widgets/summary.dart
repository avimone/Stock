import 'package:flutter/material.dart';
import 'package:Stock/models/log.dart';
import 'package:Stock/models/logs.dart';
import 'package:intl/intl.dart';

class Summary extends StatefulWidget {
  List<Log> recentTransactions;
  List<Log> dayrecentTransactions;
  List<Log> monthrecentTransactions;
  List<Log> originList;
  Summary(this.originList, this.recentTransactions, this.dayrecentTransactions,
      this.monthrecentTransactions);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < widget.recentTransactions.length; i++) {
        if (widget.recentTransactions[i].time.day == weekDay.day &&
            widget.recentTransactions[i].time.month == weekDay.month &&
            widget.recentTransactions[i].time.year == weekDay.year) {
          if (widget.recentTransactions[i].happn == 'minus') {
            totalSum += widget.recentTransactions[i].price *
                widget.recentTransactions[i].amount;
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  List<Map<String, Object>> get daygroupedTransactionValues {
    return List.generate(1, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < widget.dayrecentTransactions.length; i++) {
        if (widget.dayrecentTransactions[i].time.day == weekDay.day &&
            widget.dayrecentTransactions[i].time.month == weekDay.month &&
            widget.dayrecentTransactions[i].time.year == weekDay.year) {
          if (widget.dayrecentTransactions[i].happn == 'minus') {
            totalSum += widget.dayrecentTransactions[i].price *
                widget.dayrecentTransactions[i].amount;
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  List<Map<String, Object>> get monthgroupedTransactionValues {
    return List.generate(30, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < widget.monthrecentTransactions.length; i++) {
        if (widget.monthrecentTransactions[i].time.day == weekDay.day &&
            widget.monthrecentTransactions[i].time.month == weekDay.month &&
            widget.monthrecentTransactions[i].time.year == weekDay.year) {
          if (widget.monthrecentTransactions[i].happn == 'minus') {
            totalSum += widget.monthrecentTransactions[i].price *
                widget.monthrecentTransactions[i].amount;
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get dailytotalSpending {
    return daygroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get monthlytotalSpending {
    return monthgroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.recentTransactions);
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Daily Total ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF7A9E9F)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              dailytotalSpending.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                  color: dailytotalSpending > 500
                      ? Color(0xFF56E39F)
                      : Color(0xFFFE5F55)),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Weekly Total",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF7A9E9F)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              totalSpending.toString(),
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Monthly Total",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color(0xFF7A9E9F)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              totalSpending.toString(),
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26),
            ),
          ],
        ),
      ),
    );
  }
}
