import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/restaurant.dart';

import 'restaurant_detail_screen.dart';

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
              leading: Hero(
                tag: 'img-${restaurants[index].id}',
                child: Image.network(
                  restaurants[index].pictureId,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    child: Placeholder(),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurants[index].name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 13,
                        color: Theme.of(context).textTheme.caption!.color,
                      ),
                      SizedBox(width: 8),
                      Text(
                        restaurants[index].city,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        size: 13,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 8),
                      Text(
                        restaurants[index].rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () => Navigator.pushNamed(
                context,
                RestaurantDetailScreen.routeName,
                arguments: restaurants[index],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: constraints,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Restaurants',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'Restaurant recommendations for you',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Expanded(child: _buildList(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
