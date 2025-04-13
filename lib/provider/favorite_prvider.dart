
import 'package:aqarak/data/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';


class FavoritePrvider extends ChangeNotifier {
  final List<Property> _favorite = [];
  List<Property> get favorites => _favorite;
  void toggleFavoite(Property property) {
    if (_favorite.contains(property)) {
      _favorite.remove(property);
    } else {
      _favorite.add(property);
    }
    notifyListeners();
  }

  bool isExist(Property property) {
    final isExist = _favorite.contains(property);
    return isExist;
  }

  static FavoritePrvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoritePrvider>(context, listen: listen);
  }
  }
