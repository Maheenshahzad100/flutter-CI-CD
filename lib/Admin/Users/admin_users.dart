import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/components/custom_textfield.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminUsersPage extends StatefulWidget {
  AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  TextEditingController title = TextEditingController();

  final db = FirebaseFirestore.instance.collection('users');

  bool isLoading = false;

  
Future deleteUser(id) async{
setState(() {
  
    isLoading=true;
});
  try{
    await db.doc(id.toString()).delete();
    Navigator.pop(context);
  }
  catch(e){
    Utils.showMessage(context, e);
  }
  finally{
    setState(() {
      isLoading=false;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar("U S E R S  L I S T"),
    
      body: StreamBuilder(
        stream: db.snapshots(), 
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(color: Colors.amber[300],));
          }
          final data=snapshot.data!.docs;
       
        return Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: ListView.builder(
            
            itemCount: data.length,
            itemBuilder: (context, index) {
              final user=data[index].data();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.amber,foregroundColor: Colors.black,child: Icon(Icons.person),),
                  shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4)),
                  tileColor: const Color.fromARGB(174, 255, 236, 179),
                        title: Text("${user['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        subtitle: Text("${user['email']}", style: TextStyle( fontSize: 12),),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){},visualDensity: VisualDensity.compact, icon: FaIcon(FontAwesomeIcons.pen,size:16, color: Colors.black,)),
                            IconButton(onPressed:() {
                              showDialog(context: context, builder: (context) {
                                            return AlertDialog(
                                              title: Center(child: Text("Are You Sure?"),),
                                              content: Text("This action will permanently delete ' ${user['name']} ' from users."),
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
                                  onPressed: () => deleteUser(user['id']),
                                  child:  isLoading
                              ? CircularProgressIndicator(color: Colors.amber[300])
                              :Text("Delete"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[900],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                                ],
                                              
                                            );
                              },);
                            },visualDensity: VisualDensity.compact,  icon: FaIcon(FontAwesomeIcons.trash,size:16, color: Colors.red.shade900,),)
                          ],
                        ),
                ),
              );
            },
            
            
            ),
        );
        },
        
        
        
        
        ),
    );
  }
}
