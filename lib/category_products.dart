import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class CategoryProducts extends StatelessWidget {
   CategoryProducts({super.key, required this.categoryId, required this.categoryName});
int categoryId;
String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar(categoryName),
      body:Column(
        children: [
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
             Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoryProducts(categoryId:category['categoryId'], categoryName:category['categoryTitle']),));
              },style: ElevatedButton.styleFrom(minimumSize: Size(5, 30),shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
           backgroundColor:  category['categoryId']==categoryId   ?   Colors.amber[100] : Colors.white  , foregroundColor: Colors.black), child: Text(category['categoryTitle'])),
            ),
          );


          },);
      
      
    },
    
    
    ),
),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection("products").where('category', isEqualTo: categoryId.toString()).get(),
               builder: (context, snapshot) {
                 if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(color:Colors.amber[300]),);
                 }
                 final data=snapshot.data!.docs;
                 return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 200),
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
                                      child: ElevatedButton(onPressed: (){}, child: FaIcon(FontAwesomeIcons.cartShopping,size: 16,color:Colors.black), style: ElevatedButton.styleFrom(
                                       shape: CircleBorder(), backgroundColor: Colors.amber[300],
                                       padding: EdgeInsets.zero
                                      ),),
                                    ),
                                       
                                      
                                         
                            
                            
                              ],),
                            
                          ],
                        ),
                      ),
                    );
                  },);
               },
                ),
          ),
        ],
      ),
         
         );
 
  }
}