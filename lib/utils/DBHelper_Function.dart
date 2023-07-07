
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showMsg(BuildContext Context, String msg){
  ScaffoldMessenger.of(Context)
      .showSnackBar(SnackBar(content: Text(msg)));
}

String getFormattedDate(int dt,String format){
  return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(dt));
}