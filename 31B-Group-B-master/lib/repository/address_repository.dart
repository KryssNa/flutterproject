  import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';
import '../services/firebase_services.dart';

class AddressRepository {
  CollectionReference<Address> ref = FirebaseService.db.collection("products")
      .withConverter<Address>(
  fromFirestore: (snapshot, _) {
  return Address.fromFirebaseSnapshot(snapshot);
  },
  toFirestore: (model, _) => model.toJson(),
  );

  Stream<QuerySnapshot<Address>> getData(){
    Stream<QuerySnapshot<Address>> response =ref
        .snapshots();
    return response;
  }

  Future<Address?> getOneData(String id) async{
    DocumentSnapshot<Address> response =
        await ref.doc(id).get();
    return response.data();
  }
  Future<void>deleteAddress(String id) async{
    await ref.doc(id).delete();
  }

  Future<void>addAddress(Address data) async{
    await ref.add(data);
  }
}