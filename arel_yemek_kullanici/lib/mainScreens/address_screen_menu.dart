import 'package:arel_yemek_kullanici/assistantMethods/address_changer.dart';
import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/mainScreens/save_address_screen.dart';
import 'package:arel_yemek_kullanici/models/address.dart';
import 'package:arel_yemek_kullanici/widgets/address_design_menu.dart';
import 'package:arel_yemek_kullanici/widgets/progres_bar.dart';
import 'package:arel_yemek_kullanici/widgets/simple_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreenMenu extends StatefulWidget {

  final double? totalAmount;
  final String? sellerUID;

  AddressScreenMenu({this.totalAmount, this.sellerUID});

  @override
  State<AddressScreenMenu> createState() => _AddressScreenMenuState();
}

class _AddressScreenMenuState extends State<AddressScreenMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(title: "Adreslerim",),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Yeni Adres Ekle"),
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.add_location,color: Colors.white,),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Consumer<AddressChanger>(builder: (context, address, c){
            return Flexible(child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("userAddress").snapshots() ,
              builder: (context, snapshot){
                return !snapshot.hasData
                    ? Center(child: circularProgress(),)
                    : snapshot.data!.docs.length == 0 ? Container()
                    : ListView.builder(itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index)
                  {
                    return AddressDesignMenu(
                      currentIndex: address.count,
                      value: index,
                      addressID: snapshot.data!.docs[index].id,
                      totalAmount: widget.totalAmount,
                      sellerUID: widget.sellerUID,
                      model: Address.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String,dynamic>
                      ),
                    );
                  },
                );
              },
            ),
            );
          })
        ],
      ),

    );

  }
}
