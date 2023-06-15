import 'package:cryptotracker/pages/Favorites.dart';
import 'package:cryptotracker/pages/Markets.dart';
import 'package:cryptotracker/providers.dart/Theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController viewController;

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    ThemeProvider themeprovider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Crypto Today",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      themeprovider.toggleTheme();
                    },
                    padding: EdgeInsets.all(0),
                    icon: (themeprovider.thememode == ThemeMode.light)
                        ? Icon(Icons.dark_mode)
                        : Icon(Icons.light_mode)),
              ],
            ),

      

            TabBar(
              controller: viewController,
              tabs: [

                Tab(
                  child: Text("Markets", style: Theme.of(context).textTheme.bodyText1,),
                ),

                Tab(
                  child: Text("Favorites",style: Theme.of(context).textTheme.bodyText1,),
                ),

              ],
            ),

            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                controller: viewController,
                children: [
            
                  Markets(),
            
                  Favorites(),
            
                  
                ],
                ),
            )
          ],
        ),
      )),
    );
  }
}
