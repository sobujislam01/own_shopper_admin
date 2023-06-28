
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMsg(BuildContext Context, String msg){
  ScaffoldMessenger.of(Context)
      .showSnackBar(SnackBar(content: Text(msg)));
}