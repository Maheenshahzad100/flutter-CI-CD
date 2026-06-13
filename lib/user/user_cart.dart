import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/services/cart_service.dart';
import 'package:maheen_flutter_practice/user/user_checkout.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class UserCart extends StatefulWidget {
  UserCart({super.key});

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  int itemsCount = 0;

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
        final count = snapshot.data!.docs.length;

        if (count <= 0) {
          return Center(child: Text("Your cart is empty!"));
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
                        "Rs.${cart['price']} * ${cart['qty']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          CartService.addToCart(
                            FirebaseAuth.instance.currentUser!.uid,
                            cart,
                            context,
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CartService.decreaseQty(
                            FirebaseAuth.instance.currentUser!.uid,
                            cart,
                            cart['qty'],
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        icon: FaIcon(
                          FontAwesomeIcons.minus,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CartService.removeItem(
                            FirebaseAuth.instance.currentUser!.uid,
                            cart,
                          );
                        },
                        visualDensity: VisualDensity.compact,
                        icon: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: Colors.red[900],
                          size: 16,
                        ),
                      ),
                    ],
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserCheckout(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text(
                            "Checkout",
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
