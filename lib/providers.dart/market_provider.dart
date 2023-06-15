import 'dart:async';

import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/models/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

import '../models/API.dart';

class Marketprovider with ChangeNotifier {
  bool isloading = true;
  List<CryptoCurrency> markets = [];

  Marketprovider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();
    // ignore: unused_local_variable
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isfavorite = true;
      }

      temp.add(newCrypto);
    }

    markets = temp;
    isloading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 3), () {
    //   fetchData();
    // });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addfavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removefavorites(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
