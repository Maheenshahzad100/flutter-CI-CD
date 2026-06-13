import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
   CustomTextfield({super.key, required this.label, required this.controller});
String label;
TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(8),
    child: TextFormField(
                  controller: controller,
         
                  decoration: InputDecoration(
                   
                    border: OutlineInputBorder(),
                    focusColor: Colors.amber,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    label: Text(
                    label,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
    
    );
  }
}