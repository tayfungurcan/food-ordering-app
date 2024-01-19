

import 'dart:io';

import 'package:arel_yemek/global/global.dart';
import 'package:arel_yemek/mainScreens/home_screen.dart';
import 'package:arel_yemek/widgets/error_dialog.dart';
import 'package:arel_yemek/widgets/progres_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;


class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenusUploadScreen> createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen(){
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

        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),

      ),
      body: Container(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_two,color: Colors.white, size: 200.0,),
              ElevatedButton(
                child: const Text
                  ("Yeni Menü Ekle",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  )
                ),
                onPressed: (){
                  takeImage(context);
                },
              )
            ],
          ),
        ),
      ),
    );

}
  takeImage(mContext)
  {
    return showDialog(
      context: mContext,
      builder: (context)
        {
          return SimpleDialog(
            title: const Text("Menü Resmi", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
          children: [
            SimpleDialogOption(
              child: const Text("Kamerayı Aç",
              style: TextStyle(color: Colors.amber),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: const Text("Galeriden Seç",
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: const Text("İptal",
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
          );
        }
    );
  }

  captureImageWithCamera() async
  {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720 ,
      maxWidth: 1280,

    );

    setState((){
      imageXFile;
    });

  }

  pickImageFromGallery() async
  {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720 ,
      maxWidth: 1280,

    );

    setState((){
      imageXFile;
    });

  }
  menusUploadFormScreen()
  {
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
          "Yeni Menü Ekle",
          style: const TextStyle( fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
             child: const Text(
               "Ekle",
               style: TextStyle(
                 color: Colors.deepOrangeAccent,
                 fontWeight: FontWeight.bold,
                 fontSize: 18,
                 letterSpacing: 3,
               ),
             ),
            onPressed: uploading ? null : ()=> validateUploadForm(),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information, color: Colors.orange,),
            title: Container(
              width: 250,
              child:  TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Menü Bilgisi",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.title, color: Colors.orange,),
            title: Container(
              width: 250,
              child:  TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Menü Başlığı",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  clearMenusUploadForm()
  {
    setState((){
      shortInfoController.clear();
      titleController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async
  {
    if (imageXFile != null)
      {
        if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty){

          setState((){
            uploading = true;
          });

          String downloadUrl = await uploadImage (File(imageXFile!.path));

          saveInfo(downloadUrl);

        }
        else
          {
            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(

                    message : "Lütfen Boş Alan Bırakmayınız",
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

                message : "Lütfen Bir Fotoğraf Ekleyiniz",
              );
            }
        );
      }
  }

  saveInfo(String downloadUrl)
  {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status":"available",
      "thumbnailUrl": downloadUrl,
    });
    clearMenusUploadForm();

    setState((){
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });

  }

  uploadImage (mImageFile) async
  {

    storageRef.Reference reference = storageRef.FirebaseStorage.instance
        .ref()
        .child("menus");
    
    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;

  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}
