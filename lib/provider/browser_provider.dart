import 'package:flutter/material.dart';

class Browserprovider extends ChangeNotifier
{
double linearprogress=0;
  void changeprogress(double progress)
  {
    linearprogress=progress;
    notifyListeners();
  }
}