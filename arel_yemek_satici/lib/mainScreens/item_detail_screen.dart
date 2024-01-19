
import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/home_screen.dart';
import 'package:arel_yemek/mainScreens/itemsScreen.dart';
import 'package:arel_yemek/model/items.dart';
import 'package:arel_yemek/splashScreen/splash_screen.dart';
import 'package:arel_yemek/widgets/simple_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ItemDetailsScreen extends StatefulWidget {
 final Items? model;
 ItemDetailsScreen({this.model});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {

  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();
      Navigator.push(context, MaterialPageRoute(builder: (c)=>  HomeScreen()));
      Fluttertoast.showToast(msg: "Ürün Başarıyla Silindi");
    });
  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: SimpleAppbar(title: "Ürün Detay"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),


          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(widget.model!.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
               widget.model!.price.toString() + " ₺" ,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          const SizedBox(height: 20,),

          Center(
            child: InkWell(
              onTap: ()
              {
                //delete
                deleteItem(widget.model!.itemID!);

              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.yellow,
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 2.0),
                      stops: [0.0, 1.0 ],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 30, height: 50,
                child: const Center(
                  child: Text(
                    "Ürünü Sil",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              ),
            ),

        ],
      ),

    );
  }
}

