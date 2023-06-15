import 'package:cryptotracker/models/CryptoCurrency.dart';
import 'package:cryptotracker/providers.dart/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});
  

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {



  Widget titleAndDetail(String title, String detail, CrossAxisAlignment crossAxisAlignment) {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [

          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),),


          Text(detail, style: TextStyle(
            fontSize: 17
          ),),


        ],
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20
          ),
        child: Consumer<Marketprovider>(
         builder:( context, Marketprovider,child) {

            CryptoCurrency currentCrypto = Marketprovider.fetchCryptoById(widget.id);


            return RefreshIndicator(
              onRefresh: () async {
                await Marketprovider.fetchData();
              },
              child: ListView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                children: [
                
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(currentCrypto.name! + " (${currentCrypto.symbol!.toUpperCase()}) ",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                      subtitle: Text("₹ " + currentCrypto.currentPrice!.toStringAsFixed(4), 
                      style:
                      TextStyle(
                        color: Color(0xff0395eb),
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ) ,),  
                      ),
            
            
                      SizedBox(height: 20,),
            
            
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             
                             Text("Price Change (24h)" , style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                             ),),
            
            
                             // Builder(

                                Builder(
                             builder: (context) {
                                      double priceChange =
                                          currentCrypto.priceChange24!;
                                      double priceChangePercentage =
                                          currentCrypto.priceChangePercentage24!;
            
                                      if (priceChange < 0) {
                                        return Text(
                                          "${priceChangePercentage.toStringAsFixed(2)}%  (${priceChange.toStringAsFixed(4)})",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25
                                            ),
                                        );
                                      } else {
                                        return Text(
                                          "+${priceChangePercentage.toStringAsFixed(2)}%  (+${priceChange.toStringAsFixed(4)})",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 25
                                          ),
                                        );
                                      }
            
            
                                    }
                                  ),

                        ],
                      ),
            
            
                      SizedBox(height: 30,),
            
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
            
                          
                        titleAndDetail("Market Cap", "₹ " + currentCrypto.marketCap!.
                        toStringAsFixed(4), CrossAxisAlignment.start),
            
                         titleAndDetail("Market Cap Rank", "# " + currentCrypto.marketCapRank!.
                         toString(), CrossAxisAlignment.end),
                      
                      
                      ],
                      ),
            
            
                      SizedBox(height: 30,),
            
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
            
                          
                        titleAndDetail("Low 24h", "₹ " + currentCrypto.marketCap!.
                        toStringAsFixed(4), CrossAxisAlignment.start),
            
                         titleAndDetail("High 24h", "₹ " + currentCrypto.marketCapRank!.
                         toStringAsFixed(4), CrossAxisAlignment.end),
                      
                      
                      ],
                      ),
            
            
                        SizedBox(height: 30,),
            
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
            
            
                        titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toInt().
                        toString(), CrossAxisAlignment.start),
                      
                      ],
                      ),
                      
                    
                        SizedBox(height: 30,),
            
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
            
                          titleAndDetail("All Time Low", currentCrypto.at1!.
                        toStringAsFixed(4), CrossAxisAlignment.start),
            
                          titleAndDetail("All Time High", currentCrypto.ath!.
                        toStringAsFixed(4), CrossAxisAlignment.start),
                      
                      
                      ],
                      ),
            
                ],
              ),
            );

          }
        )
        ),
      ),
    );
  }
}
