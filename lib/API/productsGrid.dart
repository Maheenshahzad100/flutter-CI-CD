import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maheen_flutter_practice/API/productDetails.dart';


class ProductsGrid extends StatefulWidget {
   ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
List products=[];

Future getData()async{
  try{
final response=await http.get(Uri.parse("https://fakestoreapi.com/products"));
products=jsonDecode(response.body);
setState(() {});

  }
  catch(e){
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
       appBar: AppBar(title: Center(child: Text("P R O D U C T S  G R I D", 
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),centerTitle: true, backgroundColor: Colors.amber.shade300,),
      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: products.isEmpty? Center(child:
         CircularProgressIndicator(color: Colors.amber.shade300,), ) 
         :
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 300),
          itemCount: products.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) =>  Productdetails(index: index),)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                shape:BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                 
                    children: [
                      Image.network(products[index]['image'], height: 120, width: 120, fit: BoxFit.contain,),
                    SizedBox(height: 10,),
                   Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Text(products[index]['title'] , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
                      
            Text("\$ ${products[index]['price']}" , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                 SizedBox(height: 5,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                height: 10,
                   child:   ListView.builder(
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                      itemCount: ((products[index]['rating']['rate'] ?? 0) as num ).toInt(),
                      itemBuilder: (context, index) => 
                           Icon(Icons.star,size:14, color: Colors.amber,),
                  
                        
                      )
                  ),
                     SizedBox(height: 10,
                      child:  ListView.builder(
                                shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                          itemCount:  5-(((products[index]['rating']['rate'] ?? 0) as num ).toInt()),
                          itemBuilder: (context, index) =>     Icon(Icons.star,size:14, color: Colors.grey[300],),)
                       ,)
               ],),
               SizedBox(height:20),
               Row(
            
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
                backgroundColor: Colors.amber[300], foregroundColor: Colors.black), child: Text("Add to Cart"))
                ],
               )
                
                      
                      
                        ],),
                      
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