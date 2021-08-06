import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantListScreen extends StatelessWidget {
  static const String routeName = '/restaurant-list';

  const RestaurantListScreen({Key? key}) : super(key: key);

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Image.network(
                restaurants[index].pictureId,
                width: 100,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  child: Placeholder(),
                ),
              ),
              title: Text(restaurants[index].name),
              subtitle: Text(restaurants[index].city),
              onTap: () {},
            );
            // return _buildArticleItem(context, restaurants[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest au Rant'),
      ),
      body: _buildList(context),
    );
  }
}
