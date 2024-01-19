
import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/models/items.dart';
import 'package:arel_yemek_kullanici/models/menus.dart';
import 'package:arel_yemek_kullanici/widgets/app_bar.dart';
import 'package:arel_yemek_kullanici/widgets/items_design.dart';
import 'package:arel_yemek_kullanici/widgets/my_drawer.dart';
import 'package:arel_yemek_kullanici/widgets/progres_bar.dart';
import 'package:arel_yemek_kullanici/widgets/text_widget_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
    body: CustomScrollView(
    slivers: [
    SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString() + "ler")),

    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.model!.sellerUID)
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items")
        .orderBy("publishedDate", descending: true)
        .snapshots(),
    builder: (context, snapshot)
    {
    return !snapshot.hasData
    ? SliverToBoxAdapter(
    child: Center(child: circularProgress(),),
    )
        : SliverStaggeredGrid.countBuilder(
    crossAxisCount: 1,
    staggeredTileBuilder: (c) => StaggeredTile.fit(1),
    itemBuilder: (context, index)
    {
    Items model = Items.fromJson(
    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
    );
    return ItemssDesignWidget(
    model: model,
    context: context,
    );
    },
    itemCount: snapshot.data!.docs.length,
    );
    },
    ),
    ],
    ),
    );
    }
}
