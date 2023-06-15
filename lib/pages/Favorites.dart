import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/providers.dart/market_provider.dart';
import 'package:cryptotracker/widgets/CryptoListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Marketprovider>(builder: (context, Marketprovider, child) {
      List<CryptoCurrency> favorites = Marketprovider.markets
          .where((element) => element.isfavorite == true)
          .toList();

      if (favorites.length > 0) {
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            CryptoCurrency currentCrypto = favorites[index];

            return CryptoListTile(currentCrypto: currentCrypto);
          },
        );
      } else {
        return Center(
          child: Text(
            "No Favorites yet",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        );
      }
    });
  }
}
