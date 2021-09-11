import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../models/restaurant.dart';
import '../screens/restaurant_detail_screen.dart';

class RestaurantListItem extends StatelessWidget {
  const RestaurantListItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: 'img-${restaurant.id}',
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
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
}
