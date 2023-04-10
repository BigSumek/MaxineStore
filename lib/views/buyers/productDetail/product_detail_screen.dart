//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/provider/cart_provider.dart';
import 'package:multi_store/utils/show_snackBar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetillScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetillScreen({super.key, required this.productData});

  @override
  State<ProductDetillScreen> createState() => _ProductDetillScreenState();
}

class _ProductDetillScreenState extends State<ProductDetillScreen> {
  String formtedDate(date) {
    final outPutFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutFormate.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartprovider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0, //ทำพื้นหลังไม่ให้นูน
        backgroundColor: Colors.white,

        iconTheme: IconThemeData(
          color: Colors.black,
        ),

        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  height: 250,
                  width: double.infinity,
                  child: PhotoView(
                      //enableRotation: true,
                      imageProvider: NetworkImage(
                    widget.productData['imageUrlLlist'][_imageIndex],
                  ))),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['imageUrlLlist'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.transparent)),
                              height: 60,
                              width: 60,
                              child: Image.network(
                                widget.productData['imageUrlLlist'][index],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'Price   ' +
                  '\฿' +
                  ' ' +
                  widget.productData['productPrice'].toStringAsFixed(2),
              style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 12),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  thickness: 2,
                )),
                Text(
                  "Product Details",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '  Model  ' + widget.productData['productName'],
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '  Stock' +
                      ' ' +
                      widget.productData['productquantity'].toStringAsFixed(0),
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    'View More',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['ProductDescription'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade500,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  This Will Product be Shipping On',
                  style: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  formtedDate(
                    widget.productData['scheduleDate'].toDate(),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Text(
              ' Available Size',
              style: TextStyle(fontSize: 18),
            ),
            children: [
              Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: _selectedSize ==
                                  widget.productData['sizeList'][index]
                              ? Colors.yellow
                              : null,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedSize =
                                    widget.productData['sizeList'][index];
                              });

                              print(_selectedSize);
                            },
                            child: Text(
                              widget.productData['sizeList'][index],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
            ],
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartprovider.getcartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    return showSnack(context, 'Please Select Size');
                  } else {
                    {
                      _cartprovider.addProductToCart(
                          widget.productData['productName'],
                          widget.productData['productId'],
                          widget.productData['imageUrlLlist'],
                          1,
                          widget.productData['productquantity'],
                          widget.productData['productPrice'],
                          widget.productData['vendorId'],
                          _selectedSize!,
                          widget.productData['scheduleDate']);

                      return showSnack(context,
                          'YOU ADDED "${widget.productData['productName']}" To Your Cart');
                    }
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _cartprovider.getcartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.grey
                  : Colors.blue.shade500,
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartprovider.getcartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'IN CART',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0),
                        )
                      : Text(
                          'Add To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
