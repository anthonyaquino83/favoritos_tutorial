import 'package:flutter/cupertino.dart';

class Favorites extends ChangeNotifier {
  final List<String> _favoriteCars = [];
  List<String> get list => _favoriteCars;

  void add(String car) {
    _favoriteCars.add(car);
    notifyListeners();
  }

  void remove(String car) {
    _favoriteCars.remove(car);
    notifyListeners();
  }
}
