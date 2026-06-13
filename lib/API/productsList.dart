import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maheen_flutter_practice/API/productDetails.dart';

class ProductsList extends StatefulWidget {
  ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List products = [];

  Future getData() async {
    try {
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );
      products = jsonDecode(response.body);
      setState(() {});
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(19, 158, 158, 158),
      appBar: AppBar(
        title: Center(
          child: Text(
            "P R O D U C T S  L I S T",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: products.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: Colors.amber.shade300),
              )
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(index: index),
                      ),
                    ),
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              products[index]['image'],
                              height: 160,
                              width: 160,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    products[index]['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),

                                  Text(
                                    "\$ ${products[index]['price']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              ((products[index]['rating']['rate'] ??
                                                          0)
                                                      as num)
                                                  .toInt(),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              5 -
                                              (((products[index]['rating']['rate'] ??
                                                          0)
                                                      as num)
                                                  .toInt()),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  2,
                                                ),
                                          ),
                                          backgroundColor: Colors.amber[300],
                                          foregroundColor: Colors.black,
                                        ),
                                        child: Text("Add to Cart"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
