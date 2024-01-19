import 'dart:async';

import 'package:arel_yemek/authentication/auth_screen.dart';
import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/home_screen.dart';
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
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/splash.jpg"),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Admin Panel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
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
