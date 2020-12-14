import 'package:flutter/material.dart';
import 'package:homebound/providers/theme.dart';
import 'package:provider/provider.dart';
import 'helpers/sizeConfig.dart';
import 'helpers/theme.dart';
import 'navigation_bar/primary_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
     providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context,theme, snapshot,) {
           return LayoutBuilder(
          builder: (context, constraints) {
          return OrientationBuilder(
          builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp( 
            title: 'Home Rent',
            debugShowCheckedModeBanner: false,
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ?  ThemeMode.dark:ThemeMode.light ,
            home: PrimayNav(),
          );
                  
          },
      );
        },
      );
        }
    )
    );
  }
}

