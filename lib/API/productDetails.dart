import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Productdetails extends StatefulWidget {
    Productdetails({super.key, required this.index});
final index;

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
Map products={};

Future getData()async{
  try{
final response=await http.get(Uri.parse("https://fakestoreapi.com/products"));
List productsList=jsonDecode(response.body);
setState(() {});
products=productsList[widget.index];

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
backgroundColor: Colors.white,
       appBar: AppBar(backgroundColor: Colors.white,),
       bottomNavigationBar: 
     
   Padding(
          padding: const EdgeInsets.all(8.0),
   child: 
 ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(2)),
          backgroundColor: Colors.amber[300], foregroundColor: Colors.black), child: Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0, horizontal:20),
                child: Text("Add to Cart", style: TextStyle(fontSize: 16),),
          ))
            ,
       
                
          
        ),
       
    body: products.isEmpty ? Center(child: CircularProgressIndicator(color:Colors.amber[300]),) :
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: ListView(
      
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 40),
            child: Image.network(products['image'], height: 450, fit: BoxFit.contain,),
          ),
    SizedBox(height: 5,),
     Align(
      alignment: AlignmentGeometry.centerLeft,
       child: Padding(
         padding: const EdgeInsets.only(left:8.0),
         child: Container(
        decoration: BoxDecoration(
           color: const Color.fromARGB(209, 255, 236, 179),
          borderRadius: BorderRadius.circular(10)
        ),
          width: 150,
         
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(child: Text(products['category'], style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold, fontSize: 14),)),
          ),
         ),
       )
     ),
          Padding(
       padding: const EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 0),
    
     
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
    
              Expanded(
                child: Text(products['title'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, overflow: TextOverflow.clip), softWrap: true,
                  ),
              ),
                       Padding(
                         padding: const EdgeInsets.only(left:18.0),
                         child: Text("\$ ${products['price']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                       )
            
                   
                   
              ],
            ),
          ),
         Row(
          children: [
             SizedBox(
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: ((products['rating']['rate']) as num).toInt(),
                itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber,),),
            ),
          ),
           SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5-(((products['rating']['rate']) as num).toInt()),
              itemBuilder: (context, index) => Icon(Icons.star, color: Colors.grey[300],),),
          ),
          Text("(${products['rating']['count']})")
          ],
         ),
    Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:14),
     child: Text(products['description'], style: TextStyle(fontSize: 16,color: Colors.grey, 
     overflow: TextOverflow.visible), softWrap: true, maxLines: 3,
             ),
    ),    
   
    
     ],
      ),
    ),
    
    
    
    
    
    
    
    );

  }
}