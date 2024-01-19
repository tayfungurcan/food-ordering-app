import 'package:arel_yemek_kullanici/assistantMethods/address_changer.dart';
import 'package:arel_yemek_kullanici/mainScreens/placed_order_screen.dart';
import 'package:arel_yemek_kullanici/models/address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {

  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
        //select this address
      },
      child: Card(
        color: Colors.amber.withOpacity(0.4),
        child: Column(
          children: [
            //adress info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex!,
                  value: widget.value!,
                  activeColor: Colors.yellow,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    print(val);
                  },),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text("Adı",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.name.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Telefon Numarası",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.phoneNumber.toString()),
                            ],

                          ),
                          TableRow(
                            children: [
                              const Text("İl",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.city.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Mahalle",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.state.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Sokak Numarası / Adı",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.streetNumber.toString()),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text("Bina Numarası ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.buildingNumber.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Daire Numarası",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.flatNumber.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Açık Adres ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.fullAddress.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),

            //button


            //button
            widget.value == Provider.of<AddressChanger>(context).count
            ? ElevatedButton(
              child: const Text("Bu Adrese Yollansın"),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(
                    builder: (c)=> PlacedOrderScreen(
                addressID : widget.addressID,
                totalAmount: widget.totalAmount,
                sellerUID: widget.sellerUID,
                )
                )
                );

              },
            )
                :Container(),
          ],
        ),
      ),
    );
  }
}

