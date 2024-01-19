import 'package:arel_yemek_kullanici/mainScreens/menus_screen.dart';
import 'package:arel_yemek_kullanici/models/menus.dart';
import 'package:arel_yemek_kullanici/models/sellers.dart';
import 'package:flutter/material.dart';

class SellersDesignWidget extends StatefulWidget
{
 Sellers? model;
 BuildContext? context;
 SellersDesignWidget({this.model, this.context});

  @override
  State<SellersDesignWidget> createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MenusScreen(model: widget.model)));
        },

      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(widget.model!.sellerAvatarUrl!,
                height: 150.0,
                fit: BoxFit.cover,

              ),
              const SizedBox(height: 1.0,),
              Text(widget.model!.sellerName!,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 20
              ),
              ),
              Text(widget.model!.sellerEmail!,
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 25
                ),
              ),

              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              )
            ],
          ),
        ),
      ),

    );
  }
}

