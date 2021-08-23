import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'common/styles.dart';
import 'models/restaurant.dart';
import 'providers/restaurant_provider.dart';
import 'screens/restaurant_detail_screen.dart';
import 'screens/restaurant_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: MaterialApp(
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
      ),
    );
  }
}
