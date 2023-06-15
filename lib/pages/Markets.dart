import 'package:cryptotracker/widgets/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/CryptoCurrency.dart';
import '../providers.dart/market_provider.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Marketprovider>(
      builder: (context, marketprovider, child) {
        if (marketprovider.isloading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketprovider.markets.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketprovider.fetchData();
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketprovider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoCurrency currentCrypto =
                        marketprovider.markets[index];

                    return CryptoListTile(currentCrypto: currentCrypto);
                  }),
            );
          } else {
            return Text("Data Not Found!");
          }
        }
      },
    );
  }
}
