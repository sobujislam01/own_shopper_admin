import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/models/purchase_model.dart';

class DBHelper {
  static const _collectionProduct = 'products';
  static const _collectionCategory = 'catagory';
  static const _collectionPurchase = 'purchase';
  static const _collectionAdmin = 'Admins';

  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static get productId => null;

  static Future<void> addNewProduct(ProductModel productModel,PurchaseModel purchaseModel){
    final writeBatch = _db.batch();
    final productDoc = _db.collection(_collectionProduct).doc();
    final purchaseDoc = _db.collection(_collectionPurchase).doc();
    productModel.id = productDoc.id;
    purchaseModel.productId = productDoc.id;
    purchaseModel.purchaseId = productDoc.id;


    writeBatch.set(productDoc, productModel.toMap());
    writeBatch.set(purchaseDoc, purchaseModel.toMap());

    return writeBatch.commit();
  }
  static Future<bool> isAdmin(String email) async{
    final snapshot = await _db.collection(_collectionAdmin).where('email',isEqualTo: email).get();
    return snapshot.docs.isNotEmpty;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllCatagory() =>
      _db.collection(_collectionCategory).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProduct() =>
      _db.collection(_collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchProductbyProductId(String productId) =>
      _db.collection(_collectionProduct).doc(productId).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllPurchase() =>
      _db.collection(_collectionPurchase).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllPurchaseByProductId(String productId) =>
      _db.collection(_collectionPurchase)
          .where('productId', isEqualTo: productId)
          .snapshots();

  static Future<void> updateImageUrl(String url, String productId){
    final doc = _db.collection(_collectionProduct).doc(productId);
    return doc.update({'image': url});
  }


}