import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/restaurant_provider.dart';
import '../widgets/restaurant_listitem.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = '/restaurant-search';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) => SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: constraints,
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
                              'Search',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                fillColor: Colors.white12,
                                hintText: 'Search your restaurant',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              onSubmitted: (value) =>
                                  Provider.of<RestaurantProvider>(context,
                                          listen: false)
                                      .searchRestaurant(query: value),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Consumer<RestaurantProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).accentColor,
                              ),
                            );
                          } else if (state.state == ResultState.HasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.searchResult.restaurants.length,
                              itemBuilder: (context, index) =>
                                  RestaurantListItem(
                                      restaurant: state
                                          .searchResult.restaurants[index]),
                            );
                          } else if (state.state == ResultState.NoData) {
                            return Center(child: Text(state.message));
                          } else if (state.state == ResultState.Error) {
                            return Center(child: Text(state.message));
                          } else {
                            return Center(
                              child: Text('Search your restaurant above!'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
