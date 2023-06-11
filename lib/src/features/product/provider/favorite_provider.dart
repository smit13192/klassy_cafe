import 'package:flutter/material.dart';
import 'package:klassy_cafe/src/features/home/service/firebase_service.dart';

class FavoriteProvider extends ChangeNotifier {
  Set<String> _favoriteId = {};

  Set<String> get favoriteId => _favoriteId;

  getAllFavoriteProductId() async {
    _favoriteId = await FirebaseService.instance().getUserFavoriteId();
    notifyListeners();
  }

  addLike(String id) async {
    await FirebaseService.instance().addLike(id);
    _favoriteId.add(id);
    notifyListeners();
  }

  removeLike(String id) async {
    await FirebaseService.instance().removeLike(id);
    _favoriteId.remove(id);
    notifyListeners();
  }
}
