import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:search_page/search_page.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      String? data = await DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json');
      setState(() => restaurants = parseRestaurants(data));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to fetch restaurant list.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    }
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) =>
          _buildListItem(context, restaurants[index]),
    );
  }

  ListTile _buildListItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: 'img-${restaurant.id}',
        child: Image.network(
          restaurant.pictureId,
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
            restaurant.name,
            style: Theme.of(context).textTheme.subtitle1,
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
                restaurant.city,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Iconsax.star1,
                size: 13,
                color: Colors.amber,
              ),
              SizedBox(width: 8),
              Text(
                restaurant.rating.toString(),
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
        arguments: restaurant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints,
              child: RefreshIndicator(
                onRefresh: _loadData,
                color: Theme.of(context).accentColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Restaurants',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              'Restaurant recommendations for you',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 9, child: _buildList(context, restaurants)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Iconsax.search_normal_1),
        tooltip: 'Search restaurant',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Restaurant>(
            items: restaurants,
            searchLabel: 'Search restaurant',
            suggestion: Center(
              child: Text('Filter restaurant by its name'),
            ),
            failure: Center(
              child: Text('No restaurant found 😓'),
            ),
            filter: (restaurant) => [
              restaurant.name,
            ],
            builder: (restaurant) => _buildListItem(context, restaurant),
          ),
        ),
      ),
    );
  }
}
