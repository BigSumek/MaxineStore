import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

//funtion to store image in firebase storage
  _uploadVendorImagrtoStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('StoreImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
    String dowloadUrl = await snapshot.ref.getDownloadURL();

    return dowloadUrl;
  }

//funtion to stpre image in firebase storage ends here

  //Function To pick store image
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePiker = ImagePicker();
    XFile? _file = await _imagePiker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  //function to pick store image ends here

//funtion to save vendor data
  Future<String> registerVendor(
    String bussinessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxRegistered,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'some error occured';

    try {
      /*if (bussinessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isNotEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxRegistered.isNotEmpty &&
          taxNumber.isNotEmpty &&
          image != null) {*/
      String storeImage = await _uploadVendorImagrtoStorage(image);
      // Save data to cloud firebase

      await _firestor.collection('vendor').doc(_auth.currentUser!.uid).set({
        'bussinessName': bussinessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': storeImage,
        'vendorId': _auth.currentUser!.uid,
        'approved': false,
      });

      /*} else {
        res = 'Please fiedls must not be empty';
      }*/
      ;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Function to save vendor data ends here
}
