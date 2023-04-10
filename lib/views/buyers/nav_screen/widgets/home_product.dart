import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/views/buyers/productDetail/product_detail_screen.dart';

class HomeProductWidget extends StatelessWidget {
  final String? categoryName;

  const HomeProductWidget({super.key, this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .where('approved', isEqualTo: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading.....");
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  Text(
                    'All  ' + categoryName.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),

            /* Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                categoryName.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),*/

            Container(
              // margin: EdgeInsets.all(2),
              height: 420,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 200 / 300,
                ),

                //scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetillScreen(
                          productData: productData,
                        );
                      }));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  productData['imageUrlLlist'][0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              productData['productName'],
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Stock' +
                                  " " +
                                  productData['productquantity']
                                      .toStringAsFixed(0),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '\฿' +
                                  " " +
                                  productData['productPrice']
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                  color: Colors.yellow.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                // separatorBuilder: (context, _) => SizedBox(
                //   width: 15,
                // ),
                itemCount: snapshot.data!.docs.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
