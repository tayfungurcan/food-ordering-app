
import 'package:arel_yemek/mainScreens/item_detail_screen.dart';
import 'package:arel_yemek/mainScreens/itemsScreen.dart';
import 'package:arel_yemek/model/items.dart';
import 'package:arel_yemek/model/menus.dart';
import 'package:flutter/material.dart';

class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;
  ItemsDesignWidget({this.model, this.context});

  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
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
              const SizedBox(height: 1,),
              Text(widget.model!.title!,
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                ),
              ),
              const SizedBox(height: 2,),
              Image.network(widget.model!.thumbnailUrl!,
                height: 150.0,
                fit: BoxFit.cover,

              ),
              const SizedBox(height: 2.0,),

              Text(widget.model!.shortInfo!,
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 15
                ),
              ),
            const SizedBox(height: 1,),
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

