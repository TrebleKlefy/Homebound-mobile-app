import 'package:flutter/material.dart';
import 'package:homebound/providers/theme.dart';
import 'package:homebound/views/homepage.dart';
import 'package:provider/provider.dart';

import 'helpers/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
     providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context,theme, snapshot) {
          return MaterialApp( 
            title: 'Home Rent',
            debugShowCheckedModeBanner: false,
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ?  ThemeMode.light:ThemeMode.dark ,
            home: Home(),
          );
        }
      ),
    );
  }
}

