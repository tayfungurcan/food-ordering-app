
import 'package:arel_yemek_kurye/authentication/auth_screen.dart';
import 'package:arel_yemek_kurye/global/global.dart';
import 'package:arel_yemek_kurye/mainScreens/earnings_screen.dart';
import 'package:arel_yemek_kurye/mainScreens/history_screen.dart';
import 'package:arel_yemek_kurye/mainScreens/new_orders_screen.dart';
import 'package:arel_yemek_kurye/mainScreens/not_yet_delivered.dart';
import 'package:arel_yemek_kurye/mainScreens/parcel_in_progress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Card makeDashboardItem(String title, IconData iconData, int index)
  {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
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
        )
            : const BoxDecoration(
      gradient: LinearGradient(
      colors: [
          Colors.deepOrangeAccent,
          Colors.amber,
          ],
          begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 2.0),
      stops: [0.0, 1.0 ],
      tileMode: TileMode.clamp,
    )
    )  ,
        child: InkWell(
          onTap: ()
          {
            if(index == 0)
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                //New Availlable Orders
              }
            if(index == 1)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>  ParcelInProgressScreen()));
              //Parcels in progres
            }
            if(index == 2)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>  NotYetDeliveredScreen()));
              //Not yet
            }
            if(index == 3)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
              //History
            }
            if(index == 4)
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));
              //total
            }
            if(index == 5)
            {
              //logout
              firebaseAuth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child:Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
  @override
  void initState(){
    super.initState();
    getPerParcelDeliveryAmount();
    getRiderPreviousEarnings();
  }
  getRiderPreviousEarnings()
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getPerParcelDeliveryAmount()
  {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("alizeb438")
        .get().then((snap)
    {
      perParcelDeliveryAmount = snap.data()!["amount"].toString();
    });
  }

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
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontFamily: "",
            letterSpacing: 2,

          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
        padding: EdgeInsets.all(2),
          children: [
            makeDashboardItem("Şuanki Siparişler", Icons.assignment, 0),
            makeDashboardItem("Devam Eden Siparişler", Icons.airport_shuttle, 1),
            makeDashboardItem("Henüz Teslim Edilmeyen", Icons.location_history, 2),
            makeDashboardItem("Geçmiş Siparişler", Icons.done_all, 3),
            makeDashboardItem("Toplam Kazancın", Icons.monetization_on, 4),
            makeDashboardItem("Çıkış Yap", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
