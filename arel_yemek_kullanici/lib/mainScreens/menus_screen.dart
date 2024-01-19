
import 'package:arel_yemek_kullanici/assistantMethods/assistant_methods.dart';
import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/mainScreens/home_screen.dart';
import 'package:arel_yemek_kullanici/models/menus.dart';
import 'package:arel_yemek_kullanici/models/sellers.dart';
import 'package:arel_yemek_kullanici/splashScreen/splash_screen.dart';
import 'package:arel_yemek_kullanici/widgets/menus_design.dart';
import 'package:arel_yemek_kullanici/widgets/my_drawer.dart';
import 'package:arel_yemek_kullanici/widgets/progres_bar.dart';
import 'package:arel_yemek_kullanici/widgets/text_widget_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenusScreen extends StatefulWidget {

  final Sellers? model;
  MenusScreen({this.model});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.yellow,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 2.0),
                stops: [0.0, 1.0 ],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()
          {
            clearCartNow(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),
        title: const Text(
          "Arel Yemek",
          style: const TextStyle( fontSize: 40),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title:  "KATEGORİLER")),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
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
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return MenusDesignWidget(
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
