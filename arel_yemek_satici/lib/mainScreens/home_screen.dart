import 'package:arel_yemek/authentication/auth_screen.dart';
import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/model/menus.dart';
import 'package:arel_yemek/uploadScreens/menus_upload_screen.dart';
import 'package:arel_yemek/widgets/info_design.dart';
import 'package:arel_yemek/widgets/my_drawer.dart';
import 'package:arel_yemek/widgets/progres_bar.dart';
import 'package:arel_yemek/widgets/text_widget_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle( fontSize: 14),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton
            (icon: const Icon(Icons.post_add, color: Colors.white,),
          onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MenusUploadScreen()));

          },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: " Menülerim")),

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
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
                     return InfoDesignWidget(
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
