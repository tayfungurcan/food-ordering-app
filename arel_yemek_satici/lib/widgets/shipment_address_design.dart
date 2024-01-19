

import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/home_screen.dart';
import 'package:arel_yemek/model/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShipmentAddressDesign extends StatelessWidget {

  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;


  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});



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
