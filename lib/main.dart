import 'package:flutter/material.dart';

import 'common/styles.dart';
import 'models/restaurant.dart';
import 'screens/restaurant_detail_screen.dart';
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
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        fontFamily: 'Red Hat Text',
      ),
      initialRoute: RestaurantListScreen.routeName,
      routes: {
        RestaurantListScreen.routeName: (context) => RestaurantListScreen(),
        RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
