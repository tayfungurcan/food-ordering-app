
import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/itemsScreen.dart';
import 'package:arel_yemek/model/menus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfoDesignWidget extends StatefulWidget
{
 Menus? model;
 BuildContext? context;
 InfoDesignWidget({this.model, this.context});

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {

  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Kategori Silindi");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
    Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
    },
      
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
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
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.model!.menuTitle!,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20
                  ),
                  ),
                  IconButton(
                      icon: Icon(
                    Icons.delete_sweep,
                    color: Colors.red,
                  ),
                    onPressed: ()
                    {
                      deleteMenu(widget.model!.menuID!);
                      //delete
                    },
                  )
                ],
              ),


              Divider(
                height: 1,
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

