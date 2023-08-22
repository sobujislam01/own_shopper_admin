import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ownshoppers/auth/auth_service.dart';
import 'package:ownshoppers/provider/product_provider.dart';
import 'package:ownshoppers/utils/constants.dart';
import 'package:provider/provider.dart';

import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  String _errMsg = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: Center(
          child: Form(
            key: _formkey,
            child: ListView(
             padding: const EdgeInsets.symmetric(horizontal: 40),
              shrinkWrap: true,
              children:[
                TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller:_emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email'
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return EmptyFieldErrMSg;
                  }
                    return null;

                },
              ),
              SizedBox(height: 20,width: 10,),
                TextFormField(
                  obscureText: _obscureText,
                  controller:_passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: (){
                          setState(() {
                            _obscureText=!_obscureText;
                          });
                        },
                      ),
                      hintText: 'Password'
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return EmptyFieldErrMSg;
                    }
                    return null;

                  },
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: _loginAdmin,
                    child: Text('LOGIN')),
                SizedBox(height: 20,width: 10,),
                Text(_errMsg),
              ],

              ),
            ),
          )
        );
  }

  void _loginAdmin() async {
    if (_formkey.currentState!.validate()){
      try{
        final uid = await AuthService.loginAdmin(_emailController.text, _passwordController.text);
        if(uid != null){

          final isAdmin = await Provider.of<ProductProvider>(context,listen: false).isAdmin(AuthService.currentUser!.email!);
          if(isAdmin){
            Navigator.pushReplacementNamed(context, DashBoardPage.routeName);
          }else{
            setState(() {
              _errMsg = 'Your email is not Register as a Admin. Plz  Use the Admin email ';
            });
          }
        }
      }on FirebaseAuthException catch (error){
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}
