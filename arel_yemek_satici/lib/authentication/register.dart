import 'dart:io';

import 'package:arel_yemek/mainScreens/home_screen.dart';
import 'package:arel_yemek/widgets/custom_textField.dart';
import 'package:arel_yemek/widgets/error_dialog.dart';
import 'package:arel_yemek/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';


class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();




  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();



  String sellerImageUrl = "";

 Future<void> _getImage() async
 {
   imageXFile = await _picker.pickImage(source: ImageSource.gallery);

   setState((){
     imageXFile;
   }

   );
 }




 Future<void> formValidation() async
 {
   if (imageXFile == null)
     {
       showDialog(context: context, builder: (c)
           {
             return ErrorDialog(

             message : "Lütfen Fotoğraf Ekleyiniz",
             );
           }
       );
     }
   else
   {
     if(passwordController.text == confirmPasswordController.text )
       {
         if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty && locationController.text.isNotEmpty )
       {
         //fotoğraf yükle
         showDialog(
             context: context,
             builder: (c)
         {
           return LoadingDialog(
             message: "Kayıt Olunuyor",
           );
         }
         );
         String fileName = DateTime.now().millisecondsSinceEpoch.toString();
         fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("sellers").child(fileName);
         fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
         fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
         await taskSnapshot.ref.getDownloadURL().then((url){
           sellerImageUrl = url;
           //save info to firestone
           authenticateSellerAndSignUp();
         }
         );
       }
         else
           {
             showDialog(
                 context: context,
                 builder: (c)
             {
               return ErrorDialog(

                 message : "Lütfen Bilgileri Eksiksiz Giriniz",
               );
             }
             );
           }
       }
     else
       {
         showDialog(
             context: context,
             builder: (c)
         {
           return ErrorDialog(

             message : "Şifreler Eşleşmiyor",
           );
         }
         );
       }
   }
 }

 void authenticateSellerAndSignUp() async
 {
  User? currentUser;

  
  await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
  ).then((auth){
    currentUser = auth.user;
  }).catchError((error){
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (c)
        {
          return ErrorDialog(

            message : error.message.toString(),
          );
        }
    );
  });
  if( currentUser != null)
    {
      saveDataToFirestore(currentUser!).then((value){
        Navigator.pop(context);
        //send user to homepage
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
 }

 Future saveDataToFirestore(User currentUser) async
 {
   FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set(
       {
         "sellerUID": currentUser.uid,
         "sellerEmail": currentUser.email,
         "sellerName": nameController.text.trim(),
         "sellerAvatarUrl": sellerImageUrl,
         "phone": phoneController.text.trim(),
         "sellerLocation":locationController.text.trim(),
         "status": "approved",
         "earnings": 0.0,


       });
   //save data locally
   sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences!.setString("uid", currentUser.uid);
   await sharedPreferences!.setString("email", currentUser.email.toString());
   await sharedPreferences!.setString("name", nameController.text.trim());
   await sharedPreferences!.setString("photoUrl", sellerImageUrl);
   await sharedPreferences!.setString("name", locationController.text.trim());
 }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10,),
            InkWell(
              onTap: ()
              {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                child: imageXFile == null ? Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,

                ) : null,
              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Adınız",
                    is0bsecre: false,
                  ),
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
                  CustomTextField(
                    data: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "Tekrar Şifrenizi Giriniz",
                    is0bsecre: true,
                  ),

                  CustomTextField(
                    data: Icons.phone,
                    controller: phoneController,
                    hintText: "Telefon Numaranızı Giriniz",
                    is0bsecre: false,

                  ),
                  CustomTextField(
                    data: Icons.location_city,
                    controller: locationController,
                    hintText: "Adresinizi Giriniz",
                    is0bsecre: false,

                  ),

                ],
              ),

            ),
            SizedBox(height: 30,),
            ElevatedButton(
                child: const Text(
                  "Kayıt Ol",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              ),
              onPressed: ()
              {
                formValidation();
              },
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
