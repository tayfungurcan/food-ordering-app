import 'package:arel_yemek_kullanici/assistantMethods/assistant_methods.dart';
import 'package:arel_yemek_kullanici/assistantMethods/cart_item_counter.dart';
import 'package:arel_yemek_kullanici/assistantMethods/total_amount.dart';
import 'package:arel_yemek_kullanici/mainScreens/address_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/home_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/item_detail_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/items_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/menus_screen.dart';
import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:arel_yemek_kullanici/splashScreen/splash_screen.dart';
import 'package:arel_yemek_kullanici/widgets/app_bar.dart';
import 'package:arel_yemek_kullanici/widgets/cart_item_design.dart';
import 'package:arel_yemek_kullanici/widgets/progres_bar.dart';
import 'package:arel_yemek_kullanici/widgets/text_widget_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {

  final String? sellerUID;

  CartScreen({this.sellerUID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;
  num totalAmount =0;

  @override
  void initState(){

    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).disPlayTotalAmount(0);
  separateItemQuantityList = separateItemQuantities();
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
        leading: IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: ()
          {

            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),
        title: const Text(
          "Arel Yemek",
          style: const TextStyle( fontSize: 35),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton
                (icon: const Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: (){

                 print("clicked");

                },
              ),
              Positioned(
                child: Stack(
                  children:  [
                    const Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.orangeAccent
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                          builder: (context,counter,c)
                          {
                            return Text(
                              counter.count.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),),
            ],
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 5,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text("Sepeti Temizle", style: TextStyle(fontSize: 14),),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.clear_all),
              onPressed: ()
              {
                clearCartNow(context);

                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

                Fluttertoast.showToast(msg: "Sepetin Temizlendi");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text("Siparişi Tamamla", style: TextStyle(fontSize: 14),),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.navigate_next),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen(
                  totalAmount:totalAmount.toDouble(),
                  sellerUID: widget.sellerUID,

                ),
                ),
                );
              },
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true,
          delegate: TextWidgetHeader(title: "Sepetim")
      ),
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
              child: cartProvider.count == 0
                ? Container()
                  : Text(
                "Toplam Fİyat: ₺" + amountProvider.tAmount.toString(),
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              ),
              ),
              );
            }),
          ),

          //sepet öğelerinin sayısını göstermek için
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID",whereIn: separateItemIDs())
                .orderBy("publishedDate",descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : snapshot.data!.docs.length ==0
                  ? //startBuildingCart()
              Container()
                  : SliverList(delegate: SliverChildBuilderDelegate((context,index)
              {
                Items model = Items.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                );

                if(index == 0)
                  {
                    totalAmount = 0;
                    totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                  }
                else
                  {
                    totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                  }
                if(snapshot.data!.docs.length - 1 == index)
                  {
                    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      Provider.of<TotalAmount>(context, listen: false).disPlayTotalAmount(totalAmount.toDouble());
                    });
                  }

                return CartItemDesign(
                  model: model,
                  context: context,
                  quanNumber: separateItemQuantityList! [index] ,
                );
              },
                childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
              ),
              );
            },
          ),
        ],
      ),
    );
  }
}
