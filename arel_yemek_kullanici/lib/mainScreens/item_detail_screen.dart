import 'package:arel_yemek_kullanici/assistantMethods/assistant_methods.dart';
import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:arel_yemek_kullanici/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemDetailsScreen extends StatefulWidget {
 final Items? model;
 ItemDetailsScreen({this.model});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {

  TextEditingController counterTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),

          Padding(
            padding: const EdgeInsets.all(3.0),
            child: NumberInputPrefabbed.roundedButtons(
              controller: counterTextEditingController,
              incDecBgColor: Colors.amber,
              min: 1,
              max: 15,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incRightDecLeft,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
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

          const SizedBox(height: 5,),

          Center(
            child: InkWell(
              onTap: ()
              {
                int itemCounter = int.parse(counterTextEditingController.text);
                //check if item exist already in cart
                List<String> separateItemIDsList = separateItemIDs() ;
                separateItemIDsList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: "Ürünü daha önce sepete eklemişsiniz.")
                :
                //add to card
                addItemToCart(widget.model!.itemID, context, itemCounter);
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
                width: MediaQuery.of(context).size.width - 30, height: 40,
                child: const Center(
                  child: Text(
                    "Sepete Ekle",
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

