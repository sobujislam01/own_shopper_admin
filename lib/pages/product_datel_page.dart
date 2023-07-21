import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ownshoppers/customwedgets/custom_progress_dialog.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:ownshoppers/utils/DBHelper_Function.dart';
import 'package:provider/provider.dart';

class ProductDatelPage extends StatefulWidget {
  static const String routeName = '/product_datel_Page';

  @override
  State<ProductDatelPage> createState() => _ProductDatelPageState();
}

class _ProductDatelPageState extends State<ProductDatelPage> {
  late ProductProvider _productProvider;
  String? _productId;
  String?_productName;
  ImageSource _imageSource = ImageSource.camera;
  bool _isUploding = false;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _productId = argList[0];
    _productName = argList[1];
    _productProvider.getAllPurchaseByProductId(_productId!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_productName!),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _productProvider.getProductByProductId(_productId!),
          builder: (context ,snapshot){
            if(snapshot.hasData){
              final product = ProductModel.formMap(snapshot.data!.data()!);
              print(product.toString());
              return Stack(
                children: [
                  ListView(
                    children: [
                      product.productImage == null ?
                          Image.asset(
                            'images/image not available.png',
                            width: double.infinity,height: 250,
                            fit: BoxFit.cover,) :
                          FadeInImage.assetNetwork(
                            image : product.productImage!,
                            placeholder: 'images/image not available.png',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        TextButton.icon(
                            onPressed: (){
                              _imageSource =ImageSource.camera;
                              _getImage();
                            },
                            icon: Icon(Icons.camera),
                            label: Text('Camera')),
                        TextButton.icon(
                            onPressed: (){
                              _imageSource =ImageSource.gallery;
                              _getImage();
                            },
                            icon: Icon(Icons.photo),
                            label: Text('Gallery')),
                      ],),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(8),
                          border: Border.all(color: Colors.cyan,width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           const Text('sale price'),
                            Text('BDT ${product.price}',style: TextStyle(fontSize: 20),),
                            TextButton(
                                onPressed: (){},
                                child: Text('update'))
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(8),
                        child: Text('Purchase History',style: TextStyle(fontSize: 20),),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(8),
                          border: Border.all(color: Colors.cyan,width: 2),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _productProvider.purchaseListOfSpecificProduct.map((e) => ListTile(
                            title: Text(getFormattedDate(e.purchaseTimestamp!.millisecondsSinceEpoch,'dd/mm/yy',)),
                            trailing:Text('BDT ${e.purchasePrice}',style: TextStyle(fontSize: 15),) ,
                            leading: CircleAvatar(
                              child: Text('${e.purchaseQuantity}'),
                            ) ,

                          )).toList(),
                        ),
                      )
                    ],
                  ),
                  if(_isUploding) const CustomProgressDialog('Please wait')
                ],
              );
            }
            if (snapshot.hasError){
              return Text('fail to fatch data');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _getImage() async{
    final imageFile = await ImagePicker().pickImage(source: _imageSource,imageQuality: 75);
    if(imageFile != null){
     setState(() {
       _isUploding = true;
     });
      _productProvider.uploadImage(File(
          imageFile.path),
          _productId!,
          _productName!).then((value) {
            setState(() {
              _isUploding = false;
            });
      }).catchError((error){
        setState(() {
          _isUploding = false;
        });
      });
    }
  }
}
