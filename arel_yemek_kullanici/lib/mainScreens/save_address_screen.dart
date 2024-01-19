import 'package:arel_yemek_kullanici/global/global.dart';
import 'package:arel_yemek_kullanici/models/address.dart';
import 'package:arel_yemek_kullanici/widgets/simple_app_bar.dart';
import 'package:arel_yemek_kullanici/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SaveAddressScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _buildingNumber = TextEditingController();
  final _streetNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppbar(title: "Arel Yemek",),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Kayıt Tamamlandı"),
          backgroundColor: Colors.amber,
        icon: const Icon(Icons.save),

        onPressed: ()
    {
      //save address info
      if(formKey.currentState!.validate())
      {
        final model = Address(
          name: _name.text.trim(),
          state: _state.text.trim(),
          fullAddress: _completeAddress.text.trim(),
          phoneNumber: _phoneNumber.text.trim(),
          flatNumber: _flatNumber.text.trim(),
          city: _city.text.trim(),
          buildingNumber : _buildingNumber.text.trim(),
          streetNumber: _streetNumber.text.trim(),
        ).toJson();
        
        FirebaseFirestore.instance.collection("users")
            .doc(sharedPreferences!.getString("uid")).collection("userAddress")
            .doc(DateTime.now().millisecondsSinceEpoch.toString())
            .set(model).then((value)
        {
          Fluttertoast.showToast(msg: "Yeni Adresiniz Kaydedildi");
          formKey.currentState!.reset();
        });
      }

    },
        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [
              const SizedBox(height: 6,),
              const Align(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Yeni Adres Ekle",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6,),


              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Adınız Giriniz",
                      controller: _name,
                    ),
                    MyTextField(
                      hint: 'Telefon Numaranız Giriniz',
                      controller: _phoneNumber,
                    ),
                    MyTextField(
                      hint: 'İliniz Giriniz',
                      controller: _city,
                    ),
                    MyTextField(
                      hint: 'Mahallenizi Giriniz',
                      controller: _state,
                    ),
                    MyTextField(
                      hint: 'Sokak Numaranızı / Adınızı Giriniz',
                      controller: _streetNumber,
                    ),
                    MyTextField(
                      hint: 'Bina Numaranızı Giriniz',
                      controller: _buildingNumber,
                    ),
                    MyTextField(
                      hint: 'Daire Numaranızı Giriniz',
                      controller: _flatNumber,
                    ),
                    MyTextField(
                      hint: 'Açık Adresinizi Giriniz',
                      controller: _completeAddress,
                    ),

                    ],
                  ),
              )
            ],
          ),
      ),
    );
  }
}
