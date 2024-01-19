import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:arel_yemek_kullanici/widgets/items_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<QuerySnapshot>? restaurantDocumentsList;
  String titleText = "";

  initSearchingRestaurant(String textEntered) async
  {
   restaurantDocumentsList = FirebaseFirestore
       .instance.collection("items")
       .where("title", isLessThanOrEqualTo : textEntered)
       .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: TextField(
          onChanged: (textEntered)
          {
            setState((){
              titleText = textEntered;

            });
            initSearchingRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Aramak İstediğiniz Ürünü Yazınız",
                hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: (){
                    initSearchingRestaurant(titleText);

                  },
                )
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantDocumentsList,
          builder: (context, snapshot){
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index)
              {
                Items model = Items.fromJson(snapshot.data!.docs[index].data()! as Map<String, dynamic>
                );
                return  ItemssDesignWidget(
                  model: model,
                  context: context,
                );

              },
          )
              : const Center(child: Text("Aradınığınız İsimde Ürün Bulunamadı"),);
          },
      ),
    );
  }
}
