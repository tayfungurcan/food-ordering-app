
import 'package:arel_yemek/authentication/auth_screen.dart';
import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/earnings_screen.dart';
import 'package:arel_yemek/mainScreens/history_screen.dart';
import 'package:arel_yemek/mainScreens/home_screen.dart';
import 'package:arel_yemek/mainScreens/new_orders_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(sharedPreferences!.getString("name")!,
                style: TextStyle(color: Colors.black,fontSize: 20),
                )
              ],
            ),
          ),

          SizedBox(height: 12,),

          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
               const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black,),
                  title: const Text(
                    "Ana Sayfa",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.black,),
                  title: const Text(
                    "Toplam Kazanç",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  const EarningsScreen()));
                  //  Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.black,),
                  title: const Text(
                    "Yeni Siparişler",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.black,),
                  title: const Text(
                    "Geçmiş Siparişler",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.black,),
                  title: const Text(
                    "Çıkış Yap",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                    });
                  }
                  ,
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

