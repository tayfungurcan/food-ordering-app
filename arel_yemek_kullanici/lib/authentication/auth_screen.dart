import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: Scaffold(
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
      automaticallyImplyLeading: false,
    title: const Text(
      "Arel Yemek",
      style: TextStyle(
       fontSize: 60,
       color: Colors.white,



      ),
    ),
       centerTitle: true,
        bottom: const TabBar
          (tabs: [
          Tab(
            icon: Icon(Icons.lock, color : Colors.white,),
            text: "Giriş Yap",
          ),
          Tab(
            icon: Icon(Icons.person, color : Colors.white,),
            text: "Kayıt Ol",
          ),
        ],
          indicatorColor: Colors.white38,
          indicatorWeight: 6,

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.yellow,
              Colors.orange,

            ]

          )
        ),
        child: const TabBarView(
          children: [
            GirisEkrani(),
            KayitEkrani(),

          ],
        ),
      ) ,
    ),
    );
  }
}
