import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maheen_flutter_practice/Auth/login.dart';
import 'package:maheen_flutter_practice/user/user_order_history.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class Userprofile extends StatefulWidget {
   Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
 final user = FirebaseAuth.instance.currentUser;

 var userData={};

 void logout(context) async{
try{
   await FirebaseAuth.instance.signOut();
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
}
catch(e){
  Utils.showMessage(context, e);
}
 }
 
Future getUserData() async {

  try{
     final id = FirebaseAuth.instance.currentUser!.uid;
  final instance = FirebaseFirestore.instance;
  final data = await instance.collection('users').doc(id).get();

  if (data.exists) {

 
   setState(() {
        userData = data.data() as Map;
   });
 
   
  }
 
}
  catch(e){
    print("Error: $e");
  }
}





@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

             appBar: AppBar(title: Center(child: Text("Hello ${user?.email}", 
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),centerTitle: true, backgroundColor: Colors.amber.shade300,

      actions: [
              IconButton(onPressed: () => Utils.showDialogueCutsom(context, userData['name'], userData['email']), icon: Icon(Icons.person))
,
        
        
        IconButton(onPressed: () => logout(context), 
      
      icon: Icon(Icons.logout)),


      
      
      
      ],),



body: Center(
  child: Column(

    children: [
       SizedBox(height: 50,),
      Center(child: CircleAvatar(backgroundColor: Colors.black,child: Icon(Icons.person,size:70,color:Colors.amber[300]),radius: 40,)),
    SizedBox(height: 50,),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.person_outline, color: Colors.amber[300],size:25),
            SizedBox(width: 50,),
        Text(userData.isEmpty ? "" : userData['name'],style: TextStyle(fontSize: 15),),
        ],
      ),
    ),
   SizedBox(height: 10,width: double.infinity,child: Divider(),),
    SizedBox(height: 10,),
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.email_outlined, color: Colors.amber[300],size:25),
            SizedBox(width: 50,),
        Text(userData.isEmpty ? "" : userData['email'],style: TextStyle(fontSize: 15,),),
        ],
           ),
     ),
        SizedBox(height: 10,width: double.infinity,child: Divider(),),
   TextButton(onPressed:(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserOrderHistory()));
   } 
   , child: Padding(
     padding: const EdgeInsets.only(top:8.0),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
       children: [
         Text("View Order History",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      Icon(Icons.arrow_forward_ios,size: 11,color: Colors.black,)
       ],
     ),
   ))

    
    
    ],
  ),
),

    );
  }
}