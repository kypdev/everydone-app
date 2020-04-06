import 'package:flutter/material.dart';

final _kanit = 'Kanit';

Widget changePasswordForm(
    {TextEditingController controller,
    Function validator,
    Widget prefixIcon,
    String labeltext,
    bool obscureText,
    Widget suffixIcon,
    }) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    validator: validator,
    cursorColor: Colors.greenAccent,
    style: TextStyle(color: Colors.greenAccent[700]),
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hoverColor: Colors.greenAccent,
      labelText: labeltext,
      errorStyle: TextStyle(
        fontFamily: _kanit,
      ),
      labelStyle: TextStyle(fontFamily: _kanit, color: Colors.greenAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(100),
      ),
      filled: true,
      prefixIcon: prefixIcon,
      fillColor: Color.alphaBlend(
        Colors.greenAccent.withOpacity(.09),
        Colors.grey.withOpacity(.04),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 1.5),
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  );
}
