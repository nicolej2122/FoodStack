import 'package:flutter/material.dart';
import 'package:foodstack/src/providers/cartProvider.dart';
import 'package:foodstack/src/providers/menuProvider.dart';
import 'package:foodstack/src/providers/orderProvider.dart';
import 'package:foodstack/src/providers/paymentProvider.dart';
import 'package:foodstack/src/providers/userLocator.dart';
import 'package:foodstack/src/providers/restaurantProvider.dart';
import 'package:foodstack/src/screens/address.dart';
import 'package:foodstack/src/screens/authentication/login.dart';
import 'package:foodstack/src/screens/authentication/reset.dart';
import 'package:foodstack/src/screens/authentication/signup.dart';
import 'package:foodstack/src/screens/authentication/verify.dart';
import 'package:foodstack/src/screens/cart.dart';
import 'package:foodstack/src/screens/checkout.dart';
import 'package:foodstack/src/screens/details.dart';
import 'package:foodstack/src/screens/favourites.dart';
import 'package:foodstack/src/screens/home.dart';
import 'package:foodstack/src/screens/joinOrders.dart';
import 'package:foodstack/src/screens/menu.dart';
import 'package:foodstack/src/screens/newOrder.dart';
import 'package:foodstack/src/screens/orderSummary.dart';
import 'package:foodstack/src/screens/profile.dart';
import 'package:foodstack/src/screens/recentOrders.dart';
import 'package:foodstack/src/screens/track.dart';
import 'package:foodstack/src/screens/wait.dart';
import 'package:foodstack/src/screens/welcome.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final StatefulWidget home;

  const App({this.home});
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLocator()),
        ChangeNotifierProvider(create: (context) => RestaurantProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider())
      ],
      child: MaterialApp(
        title: 'FoodStack',
        home: widget.home,
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/verifyEmail': (context) => VerifyScreen(),
          '/resetPassword': (context) => ResetScreen(),
          '/pickAddress': (context) => AddressScreen(),
          '/cart': (context) => CartScreen(),
          '/checkout': (context) => CheckoutScreen(),
          '/details': (context) => DetailsScreen(),
          '/favourites': (context) => FavouritesScreen(),
          '/home': (context) => HomeScreen(),
          '/joinOrders': (context) => JoinOrdersScreen(),
          '/menu': (context) => MenuScreen(),
          '/newOrder': (context) => NewOrderScreen(),
          '/orderSummary': (context) => SummaryScreen(),
          '/profile': (context) => ProfilePage(),
          '/recentOrders': (context) => RecentOrdersScreen(),
          '/trackOrder': (context) => TrackScreen(),
          '/wait': (context) => WaitScreen(),
          '/welcome': (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
