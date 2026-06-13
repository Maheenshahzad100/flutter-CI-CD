import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maheen_flutter_practice/Admin/Categories/admin_categories.dart';
import 'package:maheen_flutter_practice/Admin/Orders/admin_orders.dart';
import 'package:maheen_flutter_practice/Admin/Products/admin_products.dart';
import 'package:maheen_flutter_practice/Admin/Users/admin_users.dart';
import 'package:maheen_flutter_practice/Auth/login.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
 void logout(context) async{
try{
   await FirebaseAuth.instance.signOut();
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
}
catch(e){
  Utils.showMessage(context, e);
}
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          appBar: AppBar(title: Center(child: Text("W E L C O M E   A D M I N", 
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),centerTitle: true, backgroundColor: Colors.amber.shade300,),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsetsGeometry.all(0),
              margin: EdgeInsetsGeometry.all(0),

              child: Container(
                width: double.infinity,
                color: Colors.amber[300],

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSA1zygA3rubv-VK0DrVcQ02Po79kJhXo_A&s',
                      ),
                      radius: 44,
                    ),
                    Text("admin"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text("Products"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminProducts()),
                );
              },
            ),
            ListTile(
              title: Text("Categories"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminCategories()),
                );
              },
            ),
              ListTile(
              title: Text("Orders"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminOrders()),
                );
              },
            ),
            ListTile(
              title: Text("Users"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminUsersPage()),
                );
              },
            ),
            Spacer(),
            ListTile(
              onTap: () => logout(context),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),


body: SingleChildScrollView(
  
  child: Padding(
    padding: const EdgeInsets.only(top: 40.0, bottom: 10,left:15,right:15),
    child: Column(
      children: [
        StreamBuilder(
           stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, Snapshot) {
            if(!Snapshot.hasData){
              return CircularProgressIndicator(color:Colors.amber[300]);
            }
            final count=Snapshot.data!.docs.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Container(
                
                decoration: BoxDecoration(
                
              color: Color.fromARGB(174, 255, 236, 179),
              borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 130,
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("Total Products",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
                        ),
                         ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProducts(),));
                         }, child: Text("View",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            minimumSize: Size(55, 24),
                            shape: BeveledRectangleBorder(),
                           backgroundColor: Colors.amber[300]),
                            
                            )
                       ],
                      ),
              
              
              
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(count.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 30)),
                                                  Text("Product(s)",style: TextStyle(color: Colors.grey,fontSize: 12)),
              
                          ],
                        ),
                       Icon(Icons.shopping_bag,size: 55,)
                       ],
                      ),
                    ],
                  ),
                ),
              
                
              ),
            );
          }
        ),


StreamBuilder(
   stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (context, Snapshot) {
            if(!Snapshot.hasData){
              return CircularProgressIndicator(color:Colors.amber[300]);
            }
            final count=Snapshot.data!.docs.length;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Container(
                
                decoration: BoxDecoration(
        
      color: Color.fromARGB(174, 255, 236, 179),
      borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 130,
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("Total Orders",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
                        ),
                         ElevatedButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => AdminOrders(),));
                         }, child: Text("View",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            minimumSize: Size(55, 24),
                            shape: BeveledRectangleBorder(),
                           backgroundColor: Colors.amber[300]),
                            
                            )
                       ],
                      ),
      
      
      
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(count.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 30)),
                                                  Text("Order(s)",style: TextStyle(color: Colors.grey,fontSize: 12)),
      
                          ],
                        ),
                       Icon(Icons.shopping_cart,size: 55,)
                       ],
                      ),
                    ],
                  ),
                ),
      
                
              ),
    );
  }
),


        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, Snapshot) {
            if(!Snapshot.hasData){
              return CircularProgressIndicator(color:Colors.amber[300]);
            }
            final count=Snapshot.data!.docs.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Container(
                
                decoration: BoxDecoration(
                
              color: Color.fromARGB(174, 255, 236, 179),
              borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 130,
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("Total Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
                        ),
                         ElevatedButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => AdminCategories(),));
                         }, child: Text("View",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            minimumSize: Size(55, 24),
                            shape: BeveledRectangleBorder(),
                           backgroundColor: Colors.amber[300]),
                            
                            )
                       ],
                      ),
              
              
              
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(count.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 30)),
                                                  Text("categorie(s)",style: TextStyle(color: Colors.grey,fontSize: 12)),
              
                          ],
                        ),
                       Icon(Icons.category,size: 55,)
                       ],
                      ),
                    ],
                  ),
                ),
              
                
              ),
            );
          }
        ),

        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, Snapshot) {
            if(!Snapshot.hasData){
              return CircularProgressIndicator(color:Colors.amber[300]);
            }
            final count=Snapshot.data!.docs.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Container(
                
                decoration: BoxDecoration(
                
              color: Color.fromARGB(174, 255, 236, 179),
              borderRadius: BorderRadius.circular(8)
                ),
                width: double.infinity,
                height: 130,
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text("Total Users",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
                        ),
                         ElevatedButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUsersPage(),));
                         }, child: Text("View",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            minimumSize: Size(55, 24),
                            shape: BeveledRectangleBorder(),
                           backgroundColor: Colors.amber[300]),
                            
                            )
                       ],
                      ),
              
              
              
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(count.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 30)),
                                                  Text("User(s)",style: TextStyle(color: Colors.grey,fontSize: 12)),
              
                          ],
                        ),
                       Icon(Icons.people,size: 55,)
                       ],
                      ),
                    ],
                  ),
                ),
              
                
              ),
            );
          }
        )


















      ],
    ),
  ),
),



















    );
  }
}
