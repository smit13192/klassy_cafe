import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:klassy_cafe/src/config/string/app_strings.dart';
import 'package:klassy_cafe/src/features/home/model/product_model.dart';

class FirebaseService {
  final _instance = FirebaseFirestore.instance;
  final _authInstance = FirebaseAuth.instance;

  FirebaseService._();

  static final FirebaseService _firebaseServiceInstance = FirebaseService._();

  factory FirebaseService.instance() => _firebaseServiceInstance;

  Stream<List<String>> getSwiperPhoto() {
    return _instance
        .collection(AppStrings.swiperPhotoCollectionName)
        .snapshots()
        .map<List<String>>(
          (event) => event.docs
              .map<String>(
                (image) => image.data()[AppStrings.swiperIdName] as String,
              )
              .toList(),
        );
  }

  Stream<List<ProductModel>> getProduct() {
    return _instance
        .collection(AppStrings.productCollectionName)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (product) => ProductModel.fromJson(product.id, product.data()),
              )
              .toList(),
        );
  }

  Future<ProductModel?> readProduct(String id) async {
    final doctproduct = FirebaseFirestore.instance
        .collection(AppStrings.productCollectionName)
        .doc(id);
    final snapshot = await doctproduct.get();
    if (snapshot.exists) {
      return ProductModel.fromJson(snapshot.id, snapshot.data()!);
    }
    return null;
  }

  Future<Set<String>> getUserFavoriteId() async {
    Set<String> favoriteList = {};
    final snapshot = await _instance
        .collection(AppStrings.userCollectionName)
        .doc(_authInstance.currentUser!.email!.split('@')[0])
        .collection(AppStrings.favouriteCollectionName)
        .get();

    for (var field in snapshot.docs) {
      favoriteList.add(field.data()[AppStrings.favouriteIdName]);
    }
    return favoriteList;
  }

  Future<void> removeLike(String id) async {
    final snapshot = await _instance
        .collection(AppStrings.userCollectionName)
        .doc(_authInstance.currentUser!.email!.split('@')[0])
        .collection(AppStrings.favouriteCollectionName)
        .where(AppStrings.favouriteIdName, isEqualTo: id)
        .get();

    await FirebaseFirestore.instance
        .collection(AppStrings.userCollectionName)
        .doc(FirebaseAuth.instance.currentUser!.email!.split('@')[0])
        .collection(AppStrings.favouriteCollectionName)
        .doc(snapshot.docs.isNotEmpty ? snapshot.docs[0].id : null)
        .delete();
  }

  Future<void> addLike(String id) async {
    await FirebaseFirestore.instance
        .collection(AppStrings.userCollectionName)
        .doc(FirebaseAuth.instance.currentUser!.email!.split('@')[0])
        .collection(AppStrings.favouriteCollectionName)
        .doc()
        .set({AppStrings.favouriteIdName: id});
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> reservation({
    required String name,
    required String phoneNo,
    required DateTime date,
    required int noOfSeat,
  }) async {
    await _instance.collection(AppStrings.reservationCollectionName).doc().set({
      AppStrings.nameField: name,
      AppStrings.phoneNoField: phoneNo,
      AppStrings.dateField: date,
      AppStrings.noOfSeatField: noOfSeat,
    });
  }
}
