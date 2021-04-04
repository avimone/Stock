import 'package:Stock/Screen/item_change.dart';
import 'package:Stock/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/products.dart';

class ItemList extends StatelessWidget {
  final String id;
  final String name;
  //final String imageUrl;
  final double amount;
  final double price;
  final String userId;
  ItemList(
      this.id,
      this.name,
      //this.imageUrl,
      this.amount,
      this.price,
      this.userId);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Container(
          color: Colors.amber,
          child: Card(
            color: const Color(0xFF25C0C0),
          ),
        ),
        header: GridTileBar(
          backgroundColor: Colors.white60,
          title: Text(
            amount == null ? "no" : amount.toString(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.sync,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ItemChange(name, amount, price, id, userId)));
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
            name == null ? "no" : name,
          ),
        ),
      ),
    );
  }
}
