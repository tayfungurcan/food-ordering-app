import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
final TextEditingController? controller;
final IconData? data;
final String? hintText;
bool? is0bsecre = true;
bool? enable = true;

CustomTextField({
  this.controller,
  this.data,
  this.hintText,
  this.is0bsecre,
  this.enable,

});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        obscureText: is0bsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border:  InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
