import 'package:arel_yemek_kullanici/mainScreens/item_detail_screen.dart';
import 'package:arel_yemek_kullanici/mainScreens/items_screen.dart';
import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:arel_yemek_kullanici/models/sellers.dart';
import 'package:flutter/material.dart';

class ItemssDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;
  ItemssDesignWidget({this.model, this.context});

  @override
  State<ItemssDesignWidget> createState() => _ItemssDesignWidgetState();
}

class _ItemssDesignWidgetState extends State<ItemssDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen(model: widget.model)));
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
              Image.network(widget.model!.thumbnailUrl!,
                height: 150.0,
                fit: BoxFit.cover,

              ),
              const SizedBox(height: 1.0,),
              Text(widget.model!.title!,
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20

                ),
              ),
              Text(widget.model!.shortInfo!,
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

