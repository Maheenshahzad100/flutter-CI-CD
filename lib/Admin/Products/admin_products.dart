import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/Admin/Products/admin_add_products.dart';
import 'package:maheen_flutter_practice/Admin/Products/admin_edit_products.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminProducts extends StatefulWidget {
  AdminProducts({super.key});

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  bool isLoading = false;

  void deleteProduct(dynamic context, int id) async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(id.toString())
          .delete();
      Navigator.pop(context);
    } catch (e) {
      Utils.showMessage(context, e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar("P R O D U C T S "),
      floatingActionButton: Utils.customFloatingButtton(
        context,
        AdminAddProducts(),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }
          final data = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: data.length,

              itemBuilder: (context, index) {
                final products = data[index].data();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4),
                    ),
                    tileColor: const Color.fromARGB(174, 255, 236, 179),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(products['imageUrl']),
                    ),
                    title: Text(
                      "${products['name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${products['descriptiom']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),

                        Text(
                          "Rs.${products['price']}",
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
                          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEditProducts(id: products['id'],),)),
                          visualDensity: VisualDensity.compact,
                          icon: FaIcon(
                            FontAwesomeIcons.pen,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(child: Text("Are You Sure?")),
                                  content: Text(
                                    "This action will permanently delete ' ${products['name']} ' from products.",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber[300],
                                        foregroundColor: Colors.black,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => deleteProduct(
                                        context,
                                        products['id'],
                                      ),
                                      child: isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.amber[300],
                                            )
                                          : Text("Delete"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[900],
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          visualDensity: VisualDensity.compact,
                          icon: FaIcon(
                            FontAwesomeIcons.trash,
                            size: 16,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // child:Card(
                  //       shape:BeveledRectangleBorder(
                  //         borderRadius: BorderRadius.circular(0)
                  //       ),
                  //       color: Colors.white,
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top:8.0, left:8, right:8, bottom: 2),
                  //         child: Column(

                  //           children: [
                  //             Image.network(products['imageUrl'], height: 120, width: 120, fit: BoxFit.contain,),
                  //           SizedBox(height: 10,),
                  //          Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                 Text(products['name'] , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis,),
                  //     SizedBox(height: 5,),

                  //   Text(" ${products['descriptiom']}",maxLines: 2, overflow: TextOverflow.ellipsis , style: TextStyle(color: Colors.black, fontSize: 11),),
                  //      SizedBox(height: 5,),
                  //     Text("Rs. ${products['price']}" , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                  //    SizedBox(height: 5,),
                  //  Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //   height: 10,
                  //      child:   ListView.builder(
                  //    shrinkWrap: true,
                  //    scrollDirection: Axis.horizontal,
                  //         itemCount: ((products['rating']['rate'] ?? 0) as num ).toInt(),
                  //         itemBuilder: (context, index) =>
                  //              Icon(Icons.star,size:14, color: Colors.amber,),

                  //         )
                  //     ),
                  //        SizedBox(height: 10,
                  //         child:  ListView.builder(
                  //                   shrinkWrap: true,
                  //    scrollDirection: Axis.horizontal,
                  //             itemCount:  5-(((products['rating']['rate'] ?? 0) as num ).toInt()),
                  //             itemBuilder: (context, index) =>     Icon(Icons.star,size:14, color: Colors.grey[300],),)
                  //          ,)
                  //  ],),
                  //      SizedBox(height:5),
                  //      Row(

                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(minimumSize: Size(10, 30),shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
                  // backgroundColor: Colors.amber[300], foregroundColor: Colors.black), child: FaIcon(FontAwesomeIcons.pen,size:14, color: Colors.black,)),
                  //                   IconButton(onPressed:() {
                  //                     showDialog(context: context, builder: (context) {
                  //                                   return AlertDialog(
                  //                                     title: Center(child: Text("Are You Sure?"),),
                  //                                     content: Text("This action will permanently delete ' ${products['name']} ' from products."),
                  //                   actions: [
                  //                                         ElevatedButton(
                  //                   onPressed: () => Navigator.pop(context),
                  //                   child: Text("Cancel"),
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.amber[300],
                  //                     foregroundColor: Colors.black,
                  //                   ),
                  //                                         ),
                  //                                         ElevatedButton(
                  //                         onPressed: () => deleteProduct(context, products['id']),
                  //                         child:  isLoading
                  //                     ? CircularProgressIndicator(color: Colors.amber[300])
                  //                     :Text("Delete"),
                  //                         style: ElevatedButton.styleFrom(
                  //                           backgroundColor: Colors.red[900],
                  //                           foregroundColor: Colors.white,
                  //                         ),
                  //                       ),
                  //                                       ],

                  //                                   );
                  //                     },);
                  //                   },visualDensity: VisualDensity.compact,  icon: FaIcon(FontAwesomeIcons.trash,size:16, color: Colors.red.shade900,),)
                  //       ],
                  //      )

                  //               ],),

                  //           ],
                  //         ),
                  //       ),
                  //     ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
