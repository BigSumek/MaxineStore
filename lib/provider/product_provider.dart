import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  getFormData(
      {String? productName,
      double? productPrice,
      int? productquantity,
      String? ProductDescription,
      String? category,
      DateTime? scheduleDate,
      List<String>? imageUrlLlist,
      bool? chargeShipping,
      int? shippingChrage,
      String? brandName,
      List<String>? sizeList}) {
    if (productName != null) {
      productData['productName'] = productName;
    }
    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }
    if (productquantity != null) {
      productData['productquantity'] = productquantity;
    }
    if (category != null) {
      productData['category'] = category;
    }
    if (ProductDescription != null) {
      productData['ProductDescription'] = ProductDescription;
    }
    if (scheduleDate != null) {
      productData['scheduleDate'] = scheduleDate;
    }
    if (imageUrlLlist != null) {
      productData['imageUrlLlist'] = imageUrlLlist;
    }
    if (chargeShipping != null) {
      productData['chargeShipping'] = chargeShipping;
    }
    if (shippingChrage != null) {
      productData['shippingChrage'] = shippingChrage;
    }
    if (brandName != null) {
      productData['brandName'] = brandName;
    }
    if (sizeList != null) {
      productData['sizeList'] = sizeList;
    }

    notifyListeners();
  }

  clearData() {
    productData.cast();
    notifyListeners();
  }
}
