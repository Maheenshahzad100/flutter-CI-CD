import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/Auth/login.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isLoading = false;
var isSecure=true;

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Future registerUser(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final auth = FirebaseAuth.instance;
      final user = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      final instance = FirebaseFirestore.instance.collection('users');
      await instance.doc(user.user!.uid).set({
        'id': user.user!.uid,
        'name': name.text,
        'email': email.text,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showMessage(context, e.code);
    } catch (e, context) {
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
      backgroundColor: Colors.amber[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       
        
        children: [
          
Expanded(child: Icon(Icons.shopping_cart_rounded, size:100)),

          Center(
            child: Container(
             
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight:Radius.circular(25)),
                       color: Colors.white,
                      ),
              
              width: 500,
                height:MediaQuery.of(context).size.height*0.75,
                      
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25),
                child: Column(
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
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
                          prefixIcon: Icon(Icons.person),
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
                            "Enter your name",
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
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
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
                            "Enter your email",
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
                        controller: password,
                        obscureText:isSecure? true:false,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                           prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                          ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon:IconButton(onPressed: () {
                            setState(() {
                              isSecure=!isSecure;
                            });
                          }, icon: isSecure? Icon(Icons.visibility_off,color:Colors.grey): Icon(Icons.visibility)) ,
                       
                          focusColor: Colors.amber,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                                          borderRadius: BorderRadius.circular(16)
                          ),
                          label: Text(
                            "Enter your password",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => registerUser(context),
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.amber[300],
                          foregroundColor: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.black)
                              : Text(
                                  "Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?  "),
                        InkWell(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          ),
                          child: Text(
                            "Login here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(height:20),
                    Row(
                    children: [
                      Expanded(
                    
                        child: Divider(
                         
                          color:Colors.grey,
                        thickness:2
                        ),
                      ),
                      SizedBox(width:5),
                     Text('or', style:TextStyle(color:Colors.grey)),
                        SizedBox(width:5),
                      Expanded(
                    
                        child: Divider(
                         
                          color:Colors.grey,
                        thickness:2
                        ),
                      ),
                    
                    ],
                    ),
            
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,size:30),),
                  SizedBox(width:10),
            
                IconButton(onPressed: (){}, icon:   FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,size:30),),
                  SizedBox(width:10),
            
                    IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.black,size:30),),
                      ],
                    ),
            SizedBox(height:5),
               Text("Create With Your Social Media Account"),
            
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
