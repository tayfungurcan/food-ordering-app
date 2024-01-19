import 'package:flutter/material.dart';

class TotalAmount extends ChangeNotifier{
  double _totalAmonunt = 0 ;
  double get tAmount => _totalAmonunt;

  disPlayTotalAmount(double number) async
  {
    _totalAmonunt = number;
    await Future.delayed(const Duration(milliseconds: 100),()

    {
      notifyListeners();
    });
  }

}