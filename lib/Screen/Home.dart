import 'package:Stock/Screen/Auth.dart';
import 'package:Stock/Screen/order_history.dart';
import 'package:Stock/Widgets/item_list.dart';
import 'package:Stock/Widgets/new_item.dart';
import 'package:Stock/Widgets/summary.dart';
import 'package:Stock/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/products.dart';
import 'package:Stock/Widgets/item_list.dart';
import 'package:Stock/models/logs.dart';
import 'package:Stock/Widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  String number;
  HomeScreen({this.number});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  String id;

  var token;

  void _addNewTransaction(
      String txname, double txAmount, DateTime chosenDate, double txPrice) {
    final newTx = Product(
      name: txname,
      amount: txAmount,
      id: chosenDate.toString(),
      price: txPrice,
    );
    // imageUrl: 'https://gadgetspidy.com/pik/Asset.png');
    //   print(id);
    setState(() {
      final productsData = Provider.of<Products>(context, listen: false);
      productsData.addProduct(newTx.id, newTx.name, newTx.price, newTx.amount);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewItem(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
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
    print(token);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (route) => false);
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              }),
          IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OrderHistory()));
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = FirebaseAuth.instance.currentUser.uid;
    if (widget.number == "8866535452" || widget.number == "9106116309") {
      id = "aWfOSS3W81eprgxms6QZT11vTZr1";
    }

    token = FirebaseAuth.instance..currentUser.refreshToken;
  }
}
