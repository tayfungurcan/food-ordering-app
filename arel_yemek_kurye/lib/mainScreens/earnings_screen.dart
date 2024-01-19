import 'package:arel_yemek_kurye/global/global.dart';
import 'package:arel_yemek_kurye/mainScreens/home_screen.dart';
import 'package:arel_yemek_kurye/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';



class EarningsScreen extends StatefulWidget
{
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}




class _EarningsScreenState extends State<EarningsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                 previousRiderEarnings + "₺",
                style: const TextStyle(
                    fontSize: 80,
                    color: Colors.white,

                ),
              ),



              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
              ),

              const SizedBox(height: 40.0,),

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                },
                child: const Card(
                  color: Colors.white60,
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 140),
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),

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
