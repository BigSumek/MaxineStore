import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store/provider/cart_provider.dart';
import 'package:multi_store/views/buyers/main_sceen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'edit_profile.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.yellow.shade900,
              title: Text(
                'Checkout',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0),
              ),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.getcartItem.length,
                itemBuilder: (context, index) {
                  final cartData =
                      _cartProvider.getcartItem.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: SizedBox(
                        height: 170,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(cartData.imageUrl[0]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartData.productName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$' +
                                        ' ' +
                                        cartData.price.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                      color: Colors.yellow.shade900,
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: null,
                                    child: Text(
                                      cartData.productSize,
                                    ),
                                  ),
                                  /* Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 115,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade900,
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: cartData.quantity == 1
                                            ? null
                                            : () {
                                                _cartProvider
                                                    .decreaMent(cartData);
                                              },
                                        icon: Icon(
                                          CupertinoIcons.minus,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        cartData.quantity.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: cartData.productQuantity ==
                                                cartData.quantity
                                            ? null
                                            : () {
                                                _cartProvider
                                                    .increament(cartData);
                                              },
                                        icon: Icon(
                                          CupertinoIcons.plus,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _cartProvider.removeItem(cartData.productId);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.cart_badge_minus,
                                  ),
                                ),
                              ],
                            )*/
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            bottomSheet: data['address'] == ''
                ? TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EdirProfileScreen(
                          userData: data,
                        );
                      })).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Enter Billing Address'))
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Placing Order');
                        //we want to be able to place order,but not know , in future
                        _cartProvider.getcartItem.forEach((key, item) {
                          final orderId = Uuid().v4();
                          _firestore.collection('orders').doc(orderId).set({
                            'orderId': orderId,
                            'vendor': item.vendorId,
                            'email': data['email'],
                            'phone': data['phoneNumber'],
                            'address': data['address'],
                            'buyerId': data['buyerId'],
                            'fullName': data['fullName'],
                            'buyerPhoto': data['profileImage'],
                            'productName': item.productName,
                            'productPrice': item.price,
                            'productId': item.productId,
                            'productImage': item.imageUrl,
                            'quantity': item.productQuantity,
                            'productSize': item.productSize,
                            'scheduleData': item.scheduleDate,
                            'orderDate': DateTime.now(),
                            'accepted': false,
                          }).whenComplete(() {
                            setState(() {
                              _cartProvider.getcartItem.clear();
                            });
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }));
                          });
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'PLACE ORDER',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.yellow.shade900,
          ),
        );
      },
    );
  }
}
