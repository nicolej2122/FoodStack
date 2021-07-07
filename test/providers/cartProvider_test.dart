import 'dart:async';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodstack/src/models/cart.dart';
import 'package:foodstack/src/providers/cartProvider.dart';
import 'package:foodstack/src/services/firestoreCarts.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mock.dart';

class FirestoreCartsMock extends Mock implements FirestoreCarts {}

void main() async {
  setupFirebaseAuthMocks();

  Cart _cart;
  CartProvider _cartProvider;
  final instance = FakeFirebaseFirestore();
  final firestoreCartsMock = FirestoreCartsMock();

  setUp(() async {
    await Firebase.initializeApp();
    _cartProvider = CartProvider();
    _cart = Cart('123-456-789', '987-654-321', '456-789-123',
        'Fast Food Restaurant', 9.00, 4.00, [
      CartItem(
          foodId: '123',
          foodName: 'FoodItem',
          price: 2.50,
          quantity: 2,
          notes: ''),
      CartItem(
          foodId: '321',
          foodName: 'AnotherFoodItem',
          price: 4.00,
          quantity: 1,
          notes: 'none')
    ]);
  });

  group('Check individual values', () {
    test('Cart Id', () {
      expect(_cart.cartId, '123-456-789');
    });

    test('User Id', () {
      expect(_cart.userId, '987-654-321');
    });

    test('Restaurant Id', () {
      expect(_cart.restaurantId, '456-789-123');
    });

    test('Subtotal', () {
      expect(_cart.subtotal, 9.00);
    });

    test('Cart Item Id', () {
      expect(_cart.cartItems[1].foodId, '321');
    });

    test('Cart Item Name', () {
      expect(_cart.cartItems[1].foodName, 'AnotherFoodItem');
    });

    test('Cart Item Quantity', () {
      expect(_cart.cartItems[0].quantity, 2);
    });

    test('Cart Item Price', () {
      expect(_cart.cartItems[0].price, 2.50);
    });

    test('Cart Item Notes', () {
      expect(_cart.cartItems[0].notes, isEmpty);
    });
  });

  testWidgets('[Provider] Update when the value changes', (tester) async {
    final _providerKey = GlobalKey();
    final _childKey = GlobalKey();
    BuildContext context;
    await tester.pumpWidget(ChangeNotifierProvider<CartProvider>(
      key: _providerKey,
      create: (c) {
        context = c;
        return _cartProvider;
      },
      child: Container(key: _childKey),
    ));
// Check the context test...
    // expect(context, equals(_providerKey.currentContext));
// Check the model test (if null)...
    // expect(Provider.of<CartProvider>(_childKey.currentContext, listen: false), null);
    _cartProvider.restaurantId = '456-789-123';
    _cartProvider.restaurantName = 'Fast Food Restaurant';
    _cartProvider.deliveryFee = 4.00;
    _cartProvider.addToCart(CartItem(
        foodId: '123',
        foodName: 'FoodItem',
        price: 2.50,
        quantity: 1,
        notes: ''));
    _cartProvider.addToCart(CartItem(
        foodId: '321',
        foodName: 'AnotherFoodItem',
        price: 4.00,
        quantity: 1,
        notes: 'none'));
    _cartProvider.updateItemQuantityOf('123', 2);
    _cartProvider.getSubtotal();
    _cartProvider.confirmCart();
// Delay the pump...
    await Future.microtask(tester.pump);
// Check if the model passed (with some value) is the same as received...
    expect(Provider.of<CartProvider>(_childKey.currentContext, listen: false), _cartProvider);
    // _cartProvider.dispose();
  });
}
