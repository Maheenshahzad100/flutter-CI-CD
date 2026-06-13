import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});
void updateStatus(String status, id,context)async{
await FirebaseFirestore.instance.collection('orders').doc(id).update({
  "status":status
});

Navigator.pop(context);

}

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
      appBar: Utils.customAppBar("O R D E R S"),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('createdAt', descending: true).snapshots(),
        
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
                         Center(child:TextButton(onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            showDragHandle: true,
                         
                            context: context, builder: (context) {
                            return SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height*0.4,
                              child: Padding(
                                padding: const EdgeInsets.only(top:25.0,right:15,left:15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                     Center(child:  Text("Update the Order Status",
                                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,wordSpacing: 1),),),
                                      SizedBox(height: 30,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("PENDING", style: TextStyle(fontSize: 18,)),
                                            IconButton(onPressed: (){
                                              updateStatus('pending',order['orderId'],context);
                                            }, icon:order['status']=="pending" ?Icon(Icons.circle,color: Colors.orange,) : Icon(Icons.circle_outlined,color: Colors.orange,)),
                                        
                                          ],) ,
                                             SizedBox(width: double.infinity,height: 10,child:  Divider(),),
                                              SizedBox(height: 5,),
                                             Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("Shipped".toUpperCase(), style: TextStyle(fontSize: 18,)),
                                            IconButton(onPressed: (){
                                              updateStatus('shipped',order['orderId'],context);
                                  
                                            }, icon:order['status']=="shipped" ?Icon(Icons.circle,color: Colors.blue,) : Icon(Icons.circle_outlined,color: Colors.blue,)),
                                        
                                          ],) ,
                                             SizedBox(width: double.infinity,height: 10,child:  Divider(),),
                                              SizedBox(height: 5,),
                                  
                                               Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("Delivered".toUpperCase(), style: TextStyle(fontSize: 18,)),
                                            IconButton(onPressed: (){
                                              updateStatus('delivered',order['orderId'],context);
                                  
                                            }, icon:order['status']=="delivered" ?Icon(Icons.circle,color: Colors.green,) : Icon(Icons.circle_outlined,color: Colors.green,)),
                                        
                                          ],) ,
                                             SizedBox(width: double.infinity,height: 10,child:  Divider(),),
                                              SizedBox(height: 5,),
                                               Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text("cancelled".toUpperCase(), style: TextStyle(fontSize: 18,)),
                                            IconButton(onPressed: (){
                                              updateStatus('cancelled',order['orderId'],context);
                                  
                                            }, icon:order['status']=="cancelled" ?Icon(Icons.circle,color: Colors.red[900],) : Icon(Icons.circle_outlined,color: Colors.red[900],)),
                                        
                                          ],) ,
                                           
                                              SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },);
                         }, child:Row(children: [
                           styling(order['status']),
                           SizedBox(width:1),
                           Icon(Icons.arrow_drop_down)
                         ],)
                         
                         
                         )
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