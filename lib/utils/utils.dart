import 'package:flutter/material.dart';

class Utils {

  static showMessage(context,message){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  static showDialogueCutsom(context, name, email){
    return showDialog(context: context, builder: (context) {
    return  AlertDialog(
      
title: Center(child: Text("Profile")),
content: Column(

mainAxisSize: MainAxisSize.min,
  children: [
    Text("Name:\t$name"),
    SizedBox(height: 5,),
      Text("Email:\t$email"),
    SizedBox(height: 5,),
 
  ],
),
      );
    },);
  }
  static customAppBar(title){
    return  AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber.shade300,
      );
  }

  static customFloatingButtton(context, route){
    return  FloatingActionButton(onPressed: (){
  Navigator.push(context, MaterialPageRoute(builder: (context) => route,));
},child: Icon(Icons.add),backgroundColor: Colors.amber[300],foregroundColor: Colors.black,);
  }
}
