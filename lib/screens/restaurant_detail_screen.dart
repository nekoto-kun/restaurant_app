import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../models/category.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const String routeName = '/restaurant-detail';

  final Restaurant restaurant;

  const RestaurantDetailScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 240,
            collapsedHeight: 120,
            pinned: true,
            floating: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'img-${restaurant.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 100,
                          child: Placeholder(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            restaurant.name ?? '-',
                            style: Theme.of(context).textTheme.headline4,
                            maxLines: 2,
                            maxFontSize: 56,
                            minFontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              size: 15,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                            SizedBox(width: 8),
                            Text(
                              restaurant.city ?? '-',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.star1,
                        size: 18,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 8),
                      Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<RestaurantProvider>(context, listen: false)
                .fetchRestaurantDetail(restaurant.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: ReadMoreText(
                          restaurant.description ?? '-',
                          trimLines: 6,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          'Menus',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      ..._menuList(context),
                    ],
                  );
                } else {
                  return Text('No data');
                }
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _menuList(BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Foods',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _menuTiles(
            Provider.of<RestaurantProvider>(context, listen: false)
                    .detail
                    ?.restaurant
                    ?.menus
                    ?.foods ??
                [],
            context,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Drinks',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _menuTiles(
            Provider.of<RestaurantProvider>(context, listen: false)
                    .detail
                    ?.restaurant
                    ?.menus
                    ?.drinks ??
                [],
            context,
          ),
        ],
      ),
    ];
  }

  Padding _menuTiles(List<Category> menu, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: List.generate(
          menu.length,
          (j) => Padding(
            padding: EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/menu-item-placeholder.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    menu[j].name ?? '-',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget? child;

  PersistentHeader({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: child,
    );
  }

  @override
  double get maxExtent => 112;

  @override
  double get minExtent => 112;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
