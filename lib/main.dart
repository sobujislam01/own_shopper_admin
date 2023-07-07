import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ownshoppers/pages/dashboard_page.dart';
import 'package:ownshoppers/pages/launcher_page.dart';
import 'package:ownshoppers/pages/login_page.dart';
import 'package:ownshoppers/pages/new_product.dart';
import 'package:ownshoppers/pages/product_datel_page.dart';
import 'package:ownshoppers/pages/product_list.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LauncherPage(),
        routes: {
          LauncherPage.routeName : (context) => LauncherPage(),
          LoginPage.routeName : (context) => LoginPage(),
          DashBoardPage.routeName : (context) => DashBoardPage(),
          NewProductPage.routeName : (context) => NewProductPage(),
          ProductListPage.routeName : (context) => ProductListPage(),
          ProductDatelPage.routeName : (context) => ProductDatelPage(),
        },
      ),
    );
  }
}
