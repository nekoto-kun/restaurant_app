import 'package:flutter/material.dart';

import 'common/styles.dart';
import 'screens/restaurant_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rest au Rant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
        ),
        initialRoute: RestaurantListScreen.routeName,
        routes: {
          RestaurantListScreen.routeName: (context) => RestaurantListScreen(),
        });
  }
}
