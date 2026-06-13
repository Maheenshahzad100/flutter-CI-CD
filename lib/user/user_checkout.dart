import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/services/cart_service.dart';
import 'package:maheen_flutter_practice/user/user_checkout.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class UserCheckout extends StatefulWidget {
  UserCheckout({super.key});

  @override
  State<UserCheckout> createState() => _UserCheckoutState();
}
final uid=FirebaseAuth.instance.currentUser!.uid;
class _UserCheckoutState extends State<UserCheckout> {
 Future placeOrder(items,uid,total) async{
  try{
List orderList=[];
for(var item in items){
orderList.add({
  "id":item['id'],
  "name":item['name'],
  "price":item['price'],
  "imageUrl":item['imageUrl'],
  "qty":item["qty"]
});
}

final db=FirebaseFirestore.instance.collection('orders');
String key=DateTime.now().millisecondsSinceEpoch.toString();
await db.doc(key).set({
"orderId":key,
"userId":uid,
"total":total,
"status":"pending",
"createdAt":FieldValue.serverTimestamp(),
"items":orderList

});
Utils.showMessage(context, "Order placed successfully");
final cart=await FirebaseFirestore.instance.collection('carts').doc(uid).collection('items').get();
 for(var c in cart.docs){
await c.reference.delete();
 }
 Navigator.pop(context);
  }
  catch(e){
Utils.showMessage(context, e.toString());
  }
 }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(color: Colors.amber[300]),
          );
        }
       

        
        final data = snapshot.data!.docs;
        double total = 0;
        for (var d in data) {
          var price = double.parse(d.data()['price'].toString());
          var qty = int.parse(d.data()['qty'].toString());
          double t = price * qty;

          total += t;
        }
        return Scaffold(
          appBar: Utils.customAppBar("Y O U R   C A R T"),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final cart = data[index].data();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(4),
                  ),
                  tileColor: const Color.fromARGB(174, 255, 236, 179),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(cart['imageUrl']),
                  ),
                  title: Text(
                    "${cart['name']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Row(
                    children: [
                      SizedBox(width: 5),

                      Text(
                        "Quantity: ${cart['qty']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing:  Text(
                        "Rs. ${cart['price']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Rs. ${total}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[300],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                      placeOrder(data, uid, total);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text(
                            "Place Order",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
