import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class UserOrderHistory extends StatelessWidget {
  const UserOrderHistory({super.key});

Widget styling(status){
if(status=='pending'){
return Text(status.toString().toUpperCase(), style: TextStyle(color:Colors.orange,fontWeight: FontWeight.bold, fontSize: 12),)       ;            

}
else if(status=='shipped'){
return Text(status.toString().toUpperCase(), style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold, fontSize: 12),)   ;                

}
else if(status=='delivered'){
return Text(status.toString().toUpperCase(), style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold, fontSize: 12),)    ;               

}
else if(status=='cancelled'){
return Text(status.toString().toUpperCase(), style: TextStyle(color:Colors.red,fontWeight: FontWeight.bold, fontSize: 12),)    ;               

}
return Text(status.toString().toUpperCase(), style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontSize: 12),)      ;             
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar("O R D E R  H I S T O R Y"),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').
        where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        
         builder: (context, snapshot) {
           if(!snapshot.hasData){
            return Center(child:CircularProgressIndicator(color: Colors.amber[300],));
           }
           final data=snapshot.data!.docs;
 
         return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final order=data[index].data();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 12),
              child: Card(
                  color:Colors.white,
                  elevation: 3,
                shape:BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left:12, right:12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order No #${order['orderId']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                         Center(child:Row(children: [
                           styling(order['status']),
                           SizedBox(width:1),
                        
                         ],)
                         )
   
                      ],
                    ),
                  ),
                  for(var o in order['items'])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4),
                      ),
                      tileColor: const Color.fromARGB(174, 255, 236, 179),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(o['imageUrl']),
                      ),
                      title: Text(
                        "${o['name']}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Row(
                        children: [
                          SizedBox(width: 5),
                    
                          Text(
                            "Quantity: ${o['qty']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing:  Text(
                            "Rs. ${o['price']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ),


                  SizedBox(height: 10,)
                  ],
                ),
              ),
            );
          },
         );
         },
        )
    );
  }
}