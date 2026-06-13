import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maheen_flutter_practice/Admin/Orders/admin_orders.dart';
import 'package:maheen_flutter_practice/Admin/Users/admin_users.dart';
import 'package:maheen_flutter_practice/Admin/admin_home.dart';


import 'package:maheen_flutter_practice/Auth/login.dart';
import 'package:maheen_flutter_practice/home.dart';
import 'package:maheen_flutter_practice/onboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 void navigate(context){
Timer(Duration(seconds: 3), () async{
  final user= FirebaseAuth.instance.currentUser?.email;
  if(user==null) 
  
 {
 final SharedPreferences prefs= await SharedPreferences.getInstance();
    bool isFirst=prefs.getBool('isFirst')??true;
    if(isFirst){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Onboardingscreen(),));

    }
    else{
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
 }

 }
  else {
   
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHome(),));

    
}

},);

 }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate(context);
  }
  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber[300],
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart,size: 120,color: Colors.black,),
          SizedBox(height: 2,),
          Text("Ecommerce App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
          SizedBox(height: 5,),
          Text("Tap. Shop. Done.",style: TextStyle(fontSize: 16),)

        ],
      ),),
    );
  }
}