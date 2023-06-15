import 'package:cryptotracker/Constant.dart/Theme.dart';
import 'package:cryptotracker/models/LocalStorage.dart';
import 'package:cryptotracker/pages/Homepage.dart';
import 'package:cryptotracker/providers.dart/Theme_provider.dart';
import 'package:cryptotracker/providers.dart/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(MyApp(theme: currentTheme));
}

class MyApp extends StatelessWidget {
  final String theme;

  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Marketprovider>(
              create: (context) => Marketprovider()
              ),

          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme),
          ),
        ],

        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.thememode,
              theme: lightTheme,
              darkTheme: DarkTheme,
              home: Homepage(),
            );
          },
        )
      );
  }
}
