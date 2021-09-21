import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../providers/restaurant_provider.dart';
import '../screens/search_screen.dart';
import '../widgets/restaurant_listitem.dart';

class RestaurantListScreen extends StatelessWidget {
  static const String routeName = '/restaurant-list';

  const RestaurantListScreen({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) => RestaurantListItem(
                  restaurant: state.result.restaurants[index]),
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
            return Center(child: Text('Terjadi kesalahan'));
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => ConstrainedBox(
            constraints: constraints,
            child: RefreshIndicator(
              onRefresh: () =>
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .fetchAllRestaurants(),
              color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
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
        onPressed: () =>
            Navigator.of(context).pushNamed(SearchScreen.routeName),
      ),
    );
  }
}
