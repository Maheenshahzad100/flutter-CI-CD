import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

 class  CartService {
 static final FirebaseFirestore db= FirebaseFirestore.instance;
 static  Future addToCart(userid, product,context)async{
   try{
     final doc=await db.collection('carts').doc(userid.toString()).collection('items').doc(product['id'].toString());
    final snapshot=await doc.get();
    if(snapshot.exists){
      doc.update({"qty": FieldValue.increment(1)});
    }
    else{
      doc.set(
        {
          'id':product['id'],
          'name':product['name'],
          'price':product['price'],
          'imageUrl':product['imageUrl'],
          'qty':1,
        }
      );
    }
   }
   catch(e){
    Utils.showMessage(context, e.toString());
   }
  }

  static Future decreaseQty(userId,product,qty)async{
 final doc=await db.collection('carts').doc(userId.toString()).collection('items').doc(product['id'].toString());
if(qty<=1){
  doc.delete();
}
else{
  doc.update({"qty":FieldValue.increment(-1)});
}
  }
  static Future removeItem(userId,product)async{
     final doc=await db.collection('carts').doc(userId.toString()).collection('items').doc(product['id'].toString());
doc.delete();
  }
}
