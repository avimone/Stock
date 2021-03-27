import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Log with ChangeNotifier {
  final String id;
  final String name;
  final double amount;
  final String happn;
  final double price;
  final DateTime time;

  // bool isFavorite;

  Log({
    @required this.id,
    @required this.amount,
    @required this.name,
    @required this.happn,
    @required this.price,
    @required this.time,
    // this.isFavorite = false,
  });
}
