import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/providers.dart/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/DetailsPage.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;

  const CryptoListTile({super.key, required this.currentCrypto});

  
  @override
  Widget build(BuildContext context) {
    Marketprovider marketprovider =
        Provider.of<Marketprovider>(context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },

      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(
            width: 10,
          ),

          (currentCrypto.isfavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketprovider.addfavorite(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketprovider.removefavorites(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                    color: Colors.red,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
              style: TextStyle(
                color: Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;

            if (priceChange < 0) {
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}%  (+${priceChange.toStringAsFixed(4)})",
                style: TextStyle(color: Colors.green),
              );
            }
          }
        ),
      ],
    ),
  );
}
}
