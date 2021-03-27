import 'package:Stock/Screen/item_change.dart';
import 'package:Stock/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/products.dart';

class ItemList extends StatefulWidget {
  final String id;
  final String name;
  //final String imageUrl;
  double amount;
  double price;

  ItemList(
      this.id,
      this.name,
      //this.imageUrl,
      this.amount,
      this.price);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    print(widget.amount);
    print(widget.id);
    //  print(widget.imageUrl);
    print(widget.price);
    print(widget.name);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.asset(
          'assets/Asset.png',
          width: 600.0,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        header: GridTileBar(
          backgroundColor: Colors.white60,
          title: Text(
            widget.amount == null ? "no" : widget.amount.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.sync,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ItemChange(
                      widget.name, widget.amount, widget.price, widget.id)));
            },
            color: Colors.black87,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          //     leading: Consumer<Product>(
          //     builder: (ctx, product, _) => IconButton(
          //       icon: Icon(
          //          product.isFavorite ? Icons.favorite : Icons.favorite_border,
          //       ),
          //        color: Theme.of(context).accentColor,
          //        onPressed: () {},
          //       ),
          //   ),
          title: Text(
            widget.name == null ? "no" : widget.name,
          ),
        ),
      ),
    );
  }
/*
  void removeItem(String xid) {
    // print(xid);
    final productsData = Provider.of<Products>(context, listen: false);
    final products = productsData.items;

    var item = products.firstWhere((element) => element.id == xid);
    setState(() {
      // int temp = int.parse(item.amount);
      // temp--;
      //  //item.amount = temp.toString();
      print(xid);
      print(item.id);
      item.amount--;
      widget.amount = item.amount;
    });

    //print(productsData.items[0].amount);
  }

  void addItem(String xid) {
    // print(xid);
    final productsData = Provider.of<Products>(context, listen: false);
    final products = productsData.items;

    var item = products.firstWhere((element) => element.id == xid);
    setState(() {
      //     int temp = int.parse(item.amount);
      //    temp++;
      //   item.amount = temp.toString();
      item.amount++;
      widget.amount = item.amount;
    });

    //  print(item.amount);
  }*/
}
