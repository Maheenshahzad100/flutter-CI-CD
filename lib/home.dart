import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:maheen_flutter_practice/shop.dart';
import 'package:maheen_flutter_practice/user/user_cart.dart';
import 'package:maheen_flutter_practice/user/user_profile.dart';
import 'package:maheen_flutter_practice/user_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
List pages=[
  UserHome(),
Shop(),
UserCart(),
Userprofile()
];

int selectedIndex=0;

class _HomePageState extends State<HomePage> {
  
  @override
  
  Widget build(BuildContext context) {
        void navigate(int index){
setState((){selectedIndex=index;});
}
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false ,
          showUnselectedLabels: false,
          selectedItemColor: Colors.amber,
          unselectedItemColor:Colors.black,
          currentIndex: selectedIndex,
          onTap: (value) => navigate(value),
          items: 
       [
                 BottomNavigationBarItem(label:"",icon:FaIcon(FontAwesomeIcons.solidHouse,size: 18,)),

         BottomNavigationBarItem(label:"",icon:FaIcon(FontAwesomeIcons.bagShopping,size: 18,)),
         BottomNavigationBarItem(label:"", icon: SizedBox(
          height: 20,
          width: 25,
          child: StreamBuilder(stream: FirebaseFirestore.instance.collection('carts').doc(FirebaseAuth.instance.currentUser!.uid).collection('items').snapshots(), 
          
          
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return FaIcon(FontAwesomeIcons.cartShopping,size: 18,);
            }
            final count=snapshot.data!.docs.length;
            if(count<=0){
                return FaIcon(FontAwesomeIcons.cartShopping,size: 18,);
            }
            return Stack(
            clipBehavior: Clip.none,
              children: [
                Positioned(top:0, left:0,child: FaIcon(FontAwesomeIcons.cartShopping,size: 18,)),
                Positioned(top:-6, right:-6,child: CircleAvatar(radius:8,backgroundColor: Colors.amber[300],child: Text("${count}",style:TextStyle(fontSize: 10)),))
              ],
            );
          },
          
          
          
          ),
         )),
                           BottomNavigationBarItem(label:"",icon:FaIcon(FontAwesomeIcons.solidUser,size: 18,)),


       ]
        
        ),
        body: pages[selectedIndex],
      );
  }
}