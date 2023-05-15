import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hunger_cravings/models/address_model.dart';
import 'package:hunger_cravings/repository/address_repository.dart';



class AddressViewModel with ChangeNotifier {
  AddressRepository _addressRepository = AddressRepository();
  Stream<QuerySnapshot<Address>>? _address;
  Stream<QuerySnapshot<Address>>? get address => _address;

  Future<void> getAddress() async {
    var response = _addressRepository.getData();

    _address = response;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _addressRepository.deleteAddress(id);
    notifyListeners();
  }
}
