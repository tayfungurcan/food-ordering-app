import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:flutter/material.dart';

class CartItemDesign extends StatefulWidget {

  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,
});


  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),
              const SizedBox(width: 6,),
              //title
              //quantitiy number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //title
                  Text(
                    widget.model!.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                  ),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "x",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,

                        ),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,

                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                     const Text("Fiyat=  ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      ),
                      Text(widget.model!.price.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),

                      ),
                     const Text("₺",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
