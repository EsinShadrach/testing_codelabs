import 'package:flutter/material.dart';

class Favourite extends ChangeNotifier {
  final List<int> _favouriteItems = [];

  List<int> get items => _favouriteItems;

  void add(int itemIndex) {
    _favouriteItems.add(itemIndex);
    notifyListeners();
  }

  void remove(int itemIndex) {
    _favouriteItems.remove(itemIndex);
    notifyListeners();
  }
}
