import 'dart:async';


import 'package:arel_yemek_kullanici/authentication/auth_screen.dart';
import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/mainScreens/home_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {

  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  
  startTimer()
  {
    Timer(const Duration(seconds: 3), () async{
      if(firebaseAuth.currentUser != null)
        {
          //if seller is loggedin already
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const HomeScreen() ));
        }
        else
          {
            //if seller is not loggedin already
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const AuthScreen() ));
          }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  
  @override

  Widget build(BuildContext context) {

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.orange, Colors.yellow,],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
            ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/welcome.png"),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Arel Yemeğe Hoş Geldiniz",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,

                    letterSpacing: 3,

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
