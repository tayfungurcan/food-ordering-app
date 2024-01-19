import 'package:arel_yemek_kullanici/assistantMethods/cart_item_counter.dart';
import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/splashScreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

separateOrderItemIDs(orderIDs)
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = List<String>.from(orderIDs) ;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":"); //56557657:7
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;
    print("\nŞuan ki Ürün Id = " + getItemId);
    separateItemIDsList.add(getItemId);
  }
  print("\nŞuan ki Ürün Listeniz");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;
  
  defaultItemList = sharedPreferences!.getStringList("userCart")!;
  
  for(i; i<defaultItemList.length; i++)
    {
      //56557657:7
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":"); //56557657:7
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;
      print("\nŞuan ki Ürün Id = " + getItemId);
      separateItemIDsList.add(getItemId);
    }
  print("\nŞuan ki Ürün Listeniz");
  print(separateItemIDsList);

  return separateItemIDsList;
}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter)
{
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter"); //56557657:7

  FirebaseFirestore.instance.collection("users")
      .doc(firebaseAuth.currentUser!.uid).update({
    "userCart": tempList,

  }).then((value)
  {
    Fluttertoast.showToast(msg: "Ürün Başarıyla Sepete Eklendi");
    
    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();
  }
  );
}
separateOrderItemQuantities(orderIDs)
{
  List<String> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = List<String>.from(orderIDs)  ;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();

    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber= int.parse(listItemCharacters[1].toString());

    print("\nÜrün Sayısı  = " + quanNumber.toString());
    separateItemQuantityList.add(quanNumber.toString());
  }
  print("\nŞuan ki ürün Miktarı");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

separateItemQuantities()
{
  List<int> separateItemQuantityList=[];
  List<String> defaultItemList=[];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();

    List<String> listItemCharacters = item.split(":").toList();

    var quanNumber= int.parse(listItemCharacters[1].toString());

    print("\nÜrün Sayısı  = " + quanNumber.toString());
    separateItemQuantityList.add(quanNumber);
  }
  print("\nŞuan ki ürün Miktarı");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}

clearCartNow(context)
{
 sharedPreferences!.setStringList("userCart", ['garbageValue']);
 List<String>? emptyList = sharedPreferences!.getStringList("userCart");

 FirebaseFirestore.instance
 .collection("users")
 .doc(firebaseAuth.currentUser!.uid)
 .update({"userCart": emptyList}).then((value)
 {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemsNumber();


 });

}