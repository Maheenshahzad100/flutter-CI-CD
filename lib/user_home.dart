import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/components/customcarosuel_slider.dart';
import 'package:maheen_flutter_practice/services/cart_service.dart';
import 'package:maheen_flutter_practice/shop.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';
class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    Future add(product)async{
  try{
await CartService.addToCart(FirebaseAuth.instance.currentUser!.uid, product, context);
Utils.showMessage(context, "Product Added to Cart");
  }
  catch(e){
Utils.showMessage(context, e.toString());
  }
}
    return  Scaffold(
  appBar: Utils.customAppBar("H O M E"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            
          children: [
        
            CustomCarouselSlider(),
        SizedBox(height: 10,),
        Padding(
        padding: const EdgeInsets.only(top:12.0, left:8, right:8, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recommended Styles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(),));
              }, child: Text("See All\t>", style: TextStyle(color: Colors.grey),))
            ],
          ),
        ),
        SizedBox(height: 10,),
            Expanded(child: StreamBuilder(stream: FirebaseFirestore.instance.collection('products').snapshots(), builder: (context, snapshot) {
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
                                child: ElevatedButton(onPressed: () => add(products), child: FaIcon(FontAwesomeIcons.cartShopping,size: 16,color:Colors.black), style: ElevatedButton.styleFrom(
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
      ),
    );
  }
}