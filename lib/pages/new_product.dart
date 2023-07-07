import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ownshoppers/db/DB_Helper.dart';
import 'package:ownshoppers/models/product_model.dart';
import 'package:ownshoppers/models/purchase_model.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:ownshoppers/utils/DBHelper_Function.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product';


  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  late ProductProvider _productProvider;
  final _formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _purchasepricecontroller = TextEditingController();
  final _describtioncontroller = TextEditingController();
  final _salepricecontroller = TextEditingController();
  final _productQuantitycontroller = TextEditingController();
   String ? category;
   DateTime ? purchasedate;

   @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
  }

   @override
  void dispose() {
    _namecontroller.dispose();
    _purchasepricecontroller.dispose();
    _describtioncontroller.dispose();
    _salepricecontroller.dispose();
    _productQuantitycontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _saveProduct, icon: Icon(Icons.done))],
        title: Text('New Product'),

      ),
      body: Center(
        child: Form(
          key: _formkey,
            child: ListView(
              padding: const EdgeInsets.all(40.0),
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    hintText: 'Product Name'
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _purchasepricecontroller,
                  decoration: InputDecoration(
                      hintText: 'Purchase Price',
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _salepricecontroller,
                  decoration: InputDecoration(
                    hintText: 'Sale Price',
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _describtioncontroller,
                  decoration: InputDecoration(
                      hintText: 'Product Describction'
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _productQuantitycontroller,
                  decoration: InputDecoration(
                      hintText: 'Product Quantity'
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10,),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    child:DropdownButtonFormField<String>(
                         hint: Text('Select Catagory'),
                    value: category ,
                    onChanged: (value){
                           setState(() {
                             category = value;
                           });
                    },
                      items: _productProvider.catagoryList.map((e) => DropdownMenuItem(
                        value: e,
                          child: Text(e)
                      )).toList(),
                      validator: (value){
                           if ( value == null || value.isEmpty){
                             return EmptyFieldErrMSg;
                           }
                           return null;
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    child: Row(
                      children: [
                        TextButton(onPressed: _showDatePickerDilog,
                            child: Text('Select Parchase Date')),
                        Text(purchasedate == null ? 'No data chosen' :DateFormat('dd/mm/yy').format(purchasedate!))
                      ],
                    ),
                )
                ),
            ]),
      ),
    ));
  }

  void _saveProduct() {
    if (_formkey.currentState!.validate()){
      final productModel = ProductModel(
        name: _namecontroller.text,
        price: num.parse(_purchasepricecontroller.text),
        saleprice: num.parse(_salepricecontroller.text),
        describtion: _describtioncontroller.text,
        catagory: category,
      );
      final purchaseModel = PurchaseModel(
          year: purchasedate!.year,
          month: purchasedate!.month,
          day: purchasedate!.day,
        purchaseTimestamp: Timestamp.fromDate(purchasedate!),
        purchaseQuantity: num.parse(_productQuantitycontroller.text),
        purchasePrice: num.parse(_purchasepricecontroller.text),
      );

      Provider.of<ProductProvider>(context,listen: false).saveProduct(productModel,purchaseModel)
          .then((value){
           setState(() {
             _namecontroller.text = '';
             _purchasepricecontroller.text = '';
             _productQuantitycontroller.text = '';
             _salepricecontroller.text = '';
             _describtioncontroller.text = '';
             category = null;
             purchasedate = null;
           });
           showMsg(context, 'Save');
      }).catchError((error){

      });
    }
  }

  void _showDatePickerDilog()async{
    final selectdeDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime.now());
    if(selectdeDate != null){
      setState(() {
        purchasedate = selectdeDate;
      });
    }
  }
}
