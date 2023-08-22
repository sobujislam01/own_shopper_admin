import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ownshoppers/pages/product_datel_page.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:provider/provider.dart';



class ProductListPage extends StatefulWidget {
  static const String routeName = '/product_list_Page';

  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;
  String ? category;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Product List'),
      ),
      body:  ListView.builder(
          itemCount:_productProvider.productList.length,
          itemBuilder: (context,index){
            final product = _productProvider.productList[index];
            return ListTile(
              onTap:() => Navigator.pushNamed(context, ProductDatelPage.routeName,arguments: [product.id,product.name]),
              title: Text(product.name!),
              subtitle: Text(product.catagory!),
              trailing: Text('BDT ${product.saleprice}'),
            );
          }

          ),

    );

  }
}
