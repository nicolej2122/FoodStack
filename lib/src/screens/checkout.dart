import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodstack/src/models/order.dart';
import 'package:foodstack/src/providers/cartProvider.dart';
import 'package:foodstack/src/providers/orderProvider.dart';
import 'package:foodstack/src/providers/userLocator.dart';
import 'package:foodstack/src/screens/home.dart';
import 'package:foodstack/src/widgets/button.dart';
import 'package:foodstack/src/widgets/header.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    final geo = Geoflutterfire();
    final userLocator = Provider.of<UserLocator>(context);
    GeoFirePoint myLocation = geo.point(
    latitude: userLocator.coordinates.latitude,
    longitude: userLocator.coordinates.longitude);

    return Scaffold(
        appBar: Header.getAppBar(back: false),
        body: Center(
            child: Column(
          children: [
            AppButton(
              buttonText: 'CONFIRM ORDER',
              onPressed: () {
                orderProvider.setOrder(Order(coordinates: myLocation));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ],
        )));
  }
}
