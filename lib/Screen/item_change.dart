import 'package:Stock/Screen/Home.dart';
import 'package:Stock/Screen/item_change.dart';
import 'package:Stock/Widgets/item_list.dart';
import 'package:Stock/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/log.dart';
import 'package:Stock/models/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Stock/models/logs.dart';

class ItemChange extends StatefulWidget {
  String name;
  double amount;
  double price;
  String id;
  String userId;
  ItemChange(this.name, this.amount, this.price, this.id, this.userId);
  @override
  _ItemChangeState createState() => _ItemChangeState();
}

class _ItemChangeState extends State<ItemChange> {
  String uid;
  final _newAmountController = TextEditingController();
  double enteredAmount = 0;
  void _submitData() {
    setState(() {
      enteredAmount = double.parse(_newAmountController.text);
      _newAmountController.text = '';
    });
  }

  void _changeData() {
    if (_newAmountController.text.isEmpty) {
      setState(() {
        enteredAmount = 0;
      });
      return;
    }
    setState(() {
      enteredAmount = double.parse(_newAmountController.text);
    });
  }

  void addchangeValues(String id) {
    final productsData = Provider.of<Products>(context, listen: false);
    final products = productsData.items;

    var item = products.firstWhere((element) => element.id == id);
    setState(() {
      //     int temp = int.parse(item.amount);
      //    temp++;
      //   item.amount = temp.toString();
      print(id);
      print(item.id);
      item.amount = enteredAmount + item.amount;
      widget.amount = item.amount;
      Provider.of<Logs>(context, listen: false).addLog(item.name, "added",
          enteredAmount, DateTime.now(), item.price, widget.userId);
      Provider.of<Products>(context, listen: false)
          .updateProduct(item.id, item);
      _newAmountController.text = '';
      enteredAmount = 0;
    });
  }

  void minuschangeValues(String id) {
    final productsData = Provider.of<Products>(context, listen: false);
    final products = productsData.items;

    var item = products.firstWhere((element) => element.id == id);
    setState(() {
      //     int temp = int.parse(item.amount);
      //    temp++;
      //   item.amount = temp.toString();
      item.amount = item.amount - enteredAmount;
      widget.amount = item.amount;
      Provider.of<Logs>(context, listen: false).addLog(item.name, "minus",
          enteredAmount, DateTime.now(), item.price, widget.userId);
      Provider.of<Products>(context, listen: false)
          .updateProduct(item.id, item);
      _newAmountController.text = '';
      enteredAmount = 0;
    });
  }

  void back() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!!! Stock will be Added'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  enteredAmount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  'This Amount of stock will be ADDED to ${widget.name}',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                addchangeValues(widget.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!!! Stock will removed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  enteredAmount.toString(),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Text(
                    'This Amount of stock will be REMOVED from ${widget.name}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                minuschangeValues(widget.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    uid = widget.userId;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFEEF5DB),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/Asset.png',
                  width: 600.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Container(
                    margin: EdgeInsets.all(3),
                    child: Text(
                      "${widget.name}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.cairo(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 1,
                ),
                Text(
                  "Current Ammount: ${widget.amount.toString()}",
                  style: GoogleFonts.cairo(fontSize: 20),
                ),
                Text(
                  "price: ${widget.price.toString()}",
                  style: GoogleFonts.cairo(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        suffixIcon: Icon(Icons.construction_sharp)),
                    controller: _newAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _changeData(),
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) => amountInput = val,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Stock amount will change by: ${enteredAmount}",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: Text(
                    'Add the Stock',
                    style: TextStyle(
                      color: Color(0xFFEEF5DB),
                    ),
                  ),
                  onPressed: () => _showMyDialog(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF7A9E9F)),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextButton(
                  child: Text(
                    'Remove the Stock',
                    style: TextStyle(
                      color: Color(0xFFEEF5DB),
                    ),
                  ),
                  onPressed: () => _showMyDialog1(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF7A9E9F)),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Color(0xFFEEF5DB),
                    ),
                  ),
                  onPressed: () => back(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF7A9E9F)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
