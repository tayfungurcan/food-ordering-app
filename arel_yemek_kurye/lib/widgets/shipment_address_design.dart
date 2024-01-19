
import 'package:arel_yemek_kurye/global/global.dart';
import 'package:arel_yemek_kurye/mainScreens/home_screen.dart';
import 'package:arel_yemek_kurye/mainScreens/new_orders_screen.dart';
import 'package:arel_yemek_kurye/mainScreens/parcel_picking_screen.dart';
import 'package:arel_yemek_kurye/models/address.dart';
import 'package:arel_yemek_kurye/splashScreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShipmentAddressDesign extends StatelessWidget {

  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;


  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});

  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId) {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "riderUID": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",

    });
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=>  ParcelPickingScreen(
      purchaserId: purchaserId,
      purchaserAddress: model!.fullAddress,
      sellerId: sellerId,
      getOrderID: getOrderID,
    )));
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.all(10.0),
          child:  Text(
            'Sipariş Detayları:',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                 const Text(
                    "Adı \n",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!),
                ],
              ),

              TableRow(
                children: [
                  const Text(
                    "Telefon Numarası",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Padding(
          padding:  EdgeInsets.all(10.0),
          child:  Text(
            'Siparişin Teslin Edileceği Adres:',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text(



            model!.fullAddress!,

            textAlign: TextAlign.justify,

          ),
        ),

        orderStatus == "ended"
            ? Container()
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                confirmedParcelShipment(context,orderId!, sellerId!, orderByUser!);
               // Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
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
                    "Siparişi Kabul Edyorum",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                    "Ana Sayfaya Dön",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20,),
      ],
    );
  }
}
