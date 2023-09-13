import 'package:flutter/material.dart';
import 'package:sample_shopping/screens/item_details_view.dart';
import 'package:sample_shopping/screens/ItemsScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SingleItemView(),
    routes: {
      ItemDetails.routeName: (ctx) => const ItemDetails(),
    },
  ));
}
