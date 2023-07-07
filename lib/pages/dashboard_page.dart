import 'package:flutter/material.dart';
import 'package:ownshoppers/auth/auth_service.dart';
import 'package:ownshoppers/pages/login_page.dart';
import 'package:ownshoppers/pages/new_product.dart';
import 'package:ownshoppers/pages/product_list.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context,listen: false);
    _productProvider.getAllCatagory();
    _productProvider.getAllProduct();
    _productProvider.getAllPurchase();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
        actions: [
          IconButton(
              onPressed: (){
                AuthService.logout().then((_){
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                });
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body:GridView.count(
        padding: const EdgeInsets.all(8.0),
          crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
              child: Text('Add product')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () => Navigator.pushNamed(context, ProductListPage.routeName),
              child: Text('View Product')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),onPressed: (){}, child: Text('View order')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){}, child: Text('Manage User')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),onPressed: (){}, child: Text('Catagory')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),onPressed: (){}, child: Text('View Reports')),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){}, child: Text('Vendors')),

        ],
      ),
    );
  }
}
