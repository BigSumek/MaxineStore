import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/views/buyers/nav_screen/category_screen.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/home_product.dart';
import 'package:multi_store/views/buyers/nav_screen/widgets/main_product_widget.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _catgoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _catgoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text("Loading Categories"),
                );
              }

              return Container(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];

                          return Padding(
                            padding: const EdgeInsets.all(2),
                            child: InputChip(
                              //selectedShadowColor: Colors.green,
                              //selectedColor: Colors.blue.shade500,
                              backgroundColor: Colors.blue.shade500,
                              onPressed: () {
                                setState(() {
                                  _selectedCategory =
                                      categoryData['categoryName'];
                                });
                              },

                              //onSelected: (bool newBool) {
                              //   setState(() {
                              //    _isSelected = !_isSelected;
                              //  });
                              // },
                              //selected: _isSelected,
                              //selectedColor: Colors.green,

                              label: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(1, 1, 1, 9),
                                  child: Text(
                                    categoryData['categoryName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryScreen();
                        }));
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              );
            },
          ),
          /*Padding(
            padding: const EdgeInsets.fromLTRB(0, 18, 0, 2),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  thickness: 2,
                )),
                Text(
                  "All Products",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),*/
          if (_selectedCategory == null) MainProductWidget(),
          if (_selectedCategory != null)
            HomeProductWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
