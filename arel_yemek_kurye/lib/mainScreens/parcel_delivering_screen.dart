import 'package:arel_yemek_kurye/global/global.dart';
import 'package:arel_yemek_kurye/mainScreens/home_screen.dart';
import 'package:arel_yemek_kurye/splashScreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParcelDeliveringScreen extends StatefulWidget {

  String? purchaserId;
  String? purchaserAddress;

  String? sellerId;
  String? getOrderId;

  ParcelDeliveringScreen({
    this.purchaserId,
    this.purchaserAddress,

    this.sellerId,
    this.getOrderId,
  });

  @override
  State<ParcelDeliveringScreen> createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen>
{
  String orderTotalAmount = "";
  confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId,purchaserAddress )
  {
    String riderNewTotalEarningAmount = ((double.parse(previousRiderEarnings)) + (double.parse(perParcelDeliveryAmount))).toString();

    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId).update({
      "status": "ended",
      "earnings" : perParcelDeliveryAmount,
    }).then((value){
      FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedPreferences!.getString("uid"))
          .update({
        "earnings": riderNewTotalEarningAmount,
      });

    }).then((value)
    {
      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerId)
          .update(
          {
            "earnings": (double.parse(orderTotalAmount) + (double.parse(previousEarnings))).toString(),
    });
  }).then((value){
    FirebaseFirestore.instance
        .collection("users")
        .doc(purchaserId)
        .collection("orders")
        .doc(getOrderId).update(
        {
      "status":"ended",
          "riderUID": sharedPreferences!.getString("uid"),
    });
    });

  }

  getOrderTotalAmount()
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get().then((snap)
    {
      orderTotalAmount = snap.data()!["totalAmount"].toString();
      widget.sellerId = snap.data()!["sellerUID"].toString();
    }).then((value) {
      getSellerData();
    });
  }

  getSellerData()
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerId)
        .get().then((snap)
    {
      previousEarnings = snap.data()!["earnings"].toString();
    });
    }

    @override
    void initState(){
    super.initState();
    getOrderTotalAmount();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/confirm2.png",
            width: 350,
          ),
          const SizedBox(height: 5,),

          const SizedBox(height: 55,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: ()

                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

                  confirmParcelHasBeenDelivered(widget.getOrderId, widget.sellerId, widget.purchaserId, widget.purchaserAddress);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.yellow,
                        ],
                        begin:  FractionalOffset(0.0, 0.0),
                        end:  FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      )
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Siparişi Teslim Ettim",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
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
