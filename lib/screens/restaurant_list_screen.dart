import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import 'restaurant_detail_screen.dart';

class RestaurantListScreen extends StatelessWidget {
  static const String routeName = '/restaurant-list';

  const RestaurantListScreen({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, state.result.restaurants[index]),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  ListTile _buildListItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: 'img-${restaurant.id}',
        child: Image.network(
          restaurant.pictureId ?? '',
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
            restaurant.name ?? '-',
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
                restaurant.city ?? '-',
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
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: constraints,
            child: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .fetchAllRestaurants(),
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
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          Text(
                            'Restaurant recommendations for you',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 9, child: _buildList(context)),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Iconsax.search_normal_1),
        tooltip: 'Search restaurant',
        onPressed: () => {},
      ),
    );
  }
}
