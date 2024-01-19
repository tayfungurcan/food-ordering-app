
import 'package:arel_yemek_kurye/authentication/auth_screen.dart';
import 'package:arel_yemek_kurye/global/global.dart';
import 'package:arel_yemek_kurye/mainScreens/home_screen.dart';
import 'package:arel_yemek_kurye/widgets/custom_textField.dart';
import 'package:arel_yemek_kurye/widgets/error_dialog.dart';
import 'package:arel_yemek_kurye/widgets/loading_dialog.dart';
import 'package:arel_yemek_kurye/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
      {
        //login
        loginNow();
      }
    else
      {
        showDialog(
            context: context,
            builder: (c)
        {
         return ErrorDialog(
           message: "Lütfen Şifrenizi ve Email Adresinizi Kontrol Ediniz.",
         );
        }
        );
      }
  }

loginNow() async
{
  showDialog(
      context: context,
      builder: (c)
      {
        return LoadingDialog (
          message: "Bilgilerini Kontrol Et.",
        );
      }
  );

  User? currentUser;
  await firebaseAuth.signInWithEmailAndPassword(
    email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
  }).catchError((error)
      {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: error.message.toString(),
              );
            }
        );
      });
  if(currentUser != null)
    {
     readDataAndSetDataLocally(currentUser!);
    }


}

  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("riders")
        .doc(currentUser.uid)
        .get()
          .then((snapshot) async{
            if(snapshot.exists)
              {
                await sharedPreferences!.setString("uid", currentUser.uid);
                await sharedPreferences!.setString("email", snapshot.data()!["riderEmail"]);
                await sharedPreferences!.setString("name", snapshot.data()!["riderName"]);
                await sharedPreferences!.setString("photoUrl", snapshot.data()!["riderAvatarUrl"]);

                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
              }
            else{
              firebaseAuth.signOut();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
              showDialog(
                  context: context,
                  builder: (c)
                  {
                    return ErrorDialog(
                      message: "Sipariş Yok",
                    );
                  }
              );


            }

    });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                  "images/signup.png",
                height:270,
              ),


            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Mail Adresinizi Giriniz",
                  is0bsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Şifrenizi Giriniz",
                  is0bsecre: true,
                ),
              ],
          ),
          ),
          ElevatedButton(
            child: const Text(
              "Giriş Yap",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            ),
            onPressed: (){
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],

      )
    );
  }
}
