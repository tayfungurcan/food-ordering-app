import 'package:arel_yemek_kullanici/mainScreens/home_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/my_orders_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/order_details_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/placed_order_screen.dart';
import 'package:arel_yemek_kullanici/models/address.dart';
import 'package:arel_yemek_kullanici/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

class ShipmentAddressDesign extends StatelessWidget {

  final Address? model;

  ShipmentAddressDesign({this.model});

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
                    "Adınız \n",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!),
                ],
              ),

              TableRow(
                children: [
                  const Text(
                    "Telefonunuz",
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyOrdersScreen()));
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
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Siparişlerim Sayfasına Dön",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
