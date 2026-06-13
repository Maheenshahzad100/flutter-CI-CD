import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/category_products.dart';
import 'package:maheen_flutter_practice/services/cart_service.dart';

import 'package:maheen_flutter_practice/utils/utils.dart';
class Shop extends StatefulWidget {
   Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
String? searchText;
Future add(product)async{
  try{
await CartService.addToCart(FirebaseAuth.instance.currentUser!.uid, product, context);
Utils.showMessage(context, "Product Added to Cart");
  }
  catch(e){
Utils.showMessage(context, e.toString());
  }
}
  @override
  Widget build(BuildContext context) {
     
    return  Scaffold(
      appBar: Utils.customAppBar("S H O P"),
      body: Column(
    
        children: [
       
      Padding(
        padding: const EdgeInsets.only(top:20.0,left:20,right:20,bottom: 5),
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: Colors.amber[100],
            cursorColor: Colors.black,
              selectionHandleColor: Colors.black
          ),
          child: SearchBar(
            leading: const FaIcon(FontAwesomeIcons.magnifyingGlass,size:14),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(side: BorderSide(color: Colors.grey.shade300),borderRadius: BorderRadiusGeometry.circular(12))),
            constraints: BoxConstraints(minHeight: 40,maxHeight: 40),
            hintText: 'Search here...',
            onChanged: (value) {
          setState(() {
            searchText=value;
          });
         
            },
            
          ),
        ),
      ),
SizedBox(
  height: 60,
  child: FutureBuilder(future: FirebaseFirestore.instance.collection('categories').get(), 
    builder: (context, snapshot) {
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator(color:Colors.amber[300]),);
      }
      final data=snapshot.data!.docs;
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          
          itemBuilder: 
          (context, index) {
                          final category=data[index].data();
          return         Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoryProducts(categoryId:category['categoryId'], categoryName:category['categoryTitle']),));
              },style: ElevatedButton.styleFrom(minimumSize: Size(5, 30),shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
                     backgroundColor: Colors.white, foregroundColor: Colors.black), child: Text(category['categoryTitle'])),
            ),
          );


          },);
      
      
    },
    
    
    ),
),
     SizedBox(height: 20,),

          Expanded(child: StreamBuilder(stream:searchText==null? FirebaseFirestore.instance.collection('products').snapshots():
          FirebaseFirestore.instance.collection('products').where('name'.toString().toLowerCase(),isGreaterThanOrEqualTo: searchText!.toLowerCase(),isLessThanOrEqualTo: "${searchText!.toLowerCase()}\uf8ff").snapshots()
          
          
          , builder: (context, snapshot) {
          if(!snapshot.hasData){
              return Center(child:CircularProgressIndicator(color: Colors.amber[300],));
             }
            final data=snapshot.data!.docs;
            return GridView.builder(
              itemCount: data.length,
              
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 200), 
            
            
            
            itemBuilder: (context, index) {
              final products=data[index].data();
              return Card(
                  color:Colors.white,
                shape:BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                
                child: Padding(
                  padding: const EdgeInsets.only(top:12.0, left:8, right:8, bottom: 2),
                  child: Column(
                 
                    children: [
       Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(products['imageUrl'], height: 100, width: 100, fit: BoxFit.cover,),
          ),
                    SizedBox(height: 10,),
                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(products['name'] , style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis,),
                               SizedBox(height: 3,),
                                 Text("Rs. ${products['price']}" , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                   
                              ],
                            ),
                                Spacer(),      
                      
                                 
                      
                              SizedBox(
                                height:35,
                                width:35,
                                child: ElevatedButton(onPressed: () {
                                  add(products);
                                }, child: FaIcon(FontAwesomeIcons.cartShopping,size: 16,color:Colors.black), style: ElevatedButton.styleFrom(
                                 shape: CircleBorder(), backgroundColor: Colors.amber[300],
                                 padding: EdgeInsets.zero
                                ),),
                              ),
                                 
                                
                                   
                      
                      
                        ],),
                      
                    ],
                  ),
                ),
              );
            },
            









            );
          },),)

        ],
      ),
    );
  }
}