import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/restaurant.dart';

import 'restaurant_detail_screen.dart';

class RestaurantListScreen extends StatefulWidget {
  static const String routeName = '/restaurant-list';

  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late List<Restaurant> restaurants = [];

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    String? data = await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
    setState(() => restaurants = parseRestaurants(data));
  }

  Widget _updateResult(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      final result = restaurants
          .where((element) => element.name.contains(_textController.text))
          .toList();
      return _buildList(context, result);
    } else {
      return _buildList(context, restaurants);
    }
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) {
    if (restaurants.length > 0) {
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
    } else {
      return Container();
    }
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
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: _textController,
                  ),
                ),
                Expanded(child: _updateResult(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
