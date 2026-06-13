import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/Admin/Products/admin_products.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminEditProducts extends StatefulWidget {
   AdminEditProducts({super.key, required this.id});
var id;
  @override
  State<AdminEditProducts> createState() => _AdminEditProductsState();
}

class _AdminEditProductsState extends State<AdminEditProducts> {
final isloading=false;

String? category;
TextEditingController name= TextEditingController();
TextEditingController imageUrl= TextEditingController();
TextEditingController desc= TextEditingController();
TextEditingController price= TextEditingController();
void addProducts()async{
  try{
final db=FirebaseFirestore.instance.collection('products');
final key=DateTime.now().millisecondsSinceEpoch;
await db.doc(key.toString()).set(
  {
    "id":key,
"name":name.text,
"imageUrl":imageUrl.text,
"descriptiom":desc.text,
"price":double.parse(price.text),
"category":category,
  }
);
  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminProducts(),));

  }
  catch(e){
  Utils.showMessage(context, e);
  }
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
             appBar: AppBar(title: Center(child: Text("E D I T  P R O D U C T S ", 
       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),centerTitle: true, backgroundColor: Colors.amber.shade300,),
body: Padding(
  padding: const EdgeInsets.only(right:12.0,left: 12.0,top: 12.0),
  child: Container(
               
            decoration: BoxDecoration(
    
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight:Radius.circular(25)),
             color: Colors.white,
            ),
                height:540,
               
            
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 6),
                  child: ListView(
                    children: [
                      
                      SizedBox(height: 30),
            
                      TextSelectionTheme(
                        data: TextSelectionThemeData(
                          selectionColor: Colors.amber[300],
  selectionHandleColor: Colors.black,
  cursorColor: Colors.black,
                        ),
                        child: TextField(
             controller: name,
                          decoration: InputDecoration(
                        
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            focusColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            label: Text(
                              "Enter product name",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          cursorColor: Colors.black,
                        
                        ),
                      ),
                      SizedBox(height: 25),
                       TextSelectionTheme(
                        data: TextSelectionThemeData(
                          selectionColor: Colors.amber[300],
  selectionHandleColor: Colors.black,
  cursorColor: Colors.black,
                        ),
                        child: TextField(
                controller: imageUrl,
                          decoration: InputDecoration(
                          
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            focusColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            label: Text(
                              "Enter product image url",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          cursorColor: Colors.black,
                        
                        ),
                      ),
                      SizedBox(height: 25),
                       TextSelectionTheme(
                        data: TextSelectionThemeData(
                          selectionColor: Colors.amber[300],
  selectionHandleColor: Colors.black,
  cursorColor: Colors.black,
                        ),
                        child: TextField(
                controller: desc,
                          decoration: InputDecoration(
                        
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            focusColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            label: Text(
                              "Enter product description",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          cursorColor: Colors.black,
                        
                        ),
                      ),
                      SizedBox(height: 25),
                      TextSelectionTheme(
                         data: TextSelectionThemeData(
                          selectionColor: Colors.amber[300],
  selectionHandleColor: Colors.black,
  cursorColor: Colors.black,
                         ),
                        child: TextField(
                      
                
                           controller: price,
                          decoration: InputDecoration(
                        
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                         
                            focusColor: Colors.amber,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                                            borderRadius: BorderRadius.circular(16)
                            ),
                            label: Text(
                              "Enter product price",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                    StreamBuilder
                    (
                      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                      
                       builder: (context, snapshot) {
                         if(!snapshot.hasData){
                          return  Center(child: CircularProgressIndicator(color: Colors.amber[300],),);
                         }
                         final categories= snapshot.data!.docs;
                         return DropdownButtonFormField(
                                                icon: Icon(Icons.category),
                                                   decoration: InputDecoration(
                                                     border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                                    
                          focusColor: Colors.amber,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                                          borderRadius: BorderRadius.circular(16)
                          ),
                                                   ),
                                                   isExpanded: true,
                                        
                                              
                                                   hint: Text("Enter product category"),
                                                   initialValue: category,
                                                   items: 
                                                   
                         List.generate(categories.length, 
                         
                         (index) {
                           final data=categories[index].data();
                           return DropdownMenuItem( value: data['categoryId'].toString(),child: Text(data['categoryTitle']),);
                           
                         },
                         )
                         
                                                 , onChanged: (value) {
                                                   setState(() {
                          category=value ;
                                                   });
                                                 },);
                       },),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => addProducts(),
                          style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.amber[300],
                            foregroundColor: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: isloading
                                ? CircularProgressIndicator(color: Colors.black)
                                : Text(
                                    "Add",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
        SizedBox(height: 2,),
                     
                 
  
                      SizedBox(height:10),
                    
  
  
                    ],
                  ),
                ),
              ),
),
    );
  }
}