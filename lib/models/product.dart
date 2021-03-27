import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  double amount;
  final double price;
  // final String imageUrl;
  // bool isFavorite;

  Product({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.price,
    // @required this.imageUrl,
    // this.isFavorite = false,ALq9NPJFlnRYQN3cIqe5YFCJ2MH3
  });
}
