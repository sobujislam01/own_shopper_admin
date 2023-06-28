import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel{
  String ? purchaseId;
  String ? productId;
  Timestamp ? purchaseTimestamp;
  int year;
  int month;
  int day;
  num purchasePrice;
  num purchaseQuantity;

  PurchaseModel(
      {this.purchaseId,
      this.productId,
      this.purchaseTimestamp,
      required this.year,
      required this.month,
      required this.day,
        this.purchasePrice = 0.0,
       this.purchaseQuantity = 1});

  Map<String,dynamic> toMap (){
    var map =<String,dynamic>{
      'purchaseId' : purchaseId,
      'productId': productId,
      'purchasePrice': purchasePrice,
      'purchaseQuantity':purchaseQuantity,
      'purchaseTimestamp':purchaseTimestamp,
      'year':year,
      'month':month,
      'day':day,
    };
    return map;
  }
  factory PurchaseModel.formMap(Map<String,dynamic>map) => PurchaseModel(
    purchaseId: map['purchaseId'],
    productId: map['productId'],
    purchasePrice: map['purchasePrice'],
    purchaseQuantity: map['purchaseQuantity'],
    purchaseTimestamp: map['purchaseTimestamp'],
    year: map['year'],
    month: map['month'],
    day: map['day'],
  );
}