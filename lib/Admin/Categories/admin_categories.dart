import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maheen_flutter_practice/components/custom_textfield.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';

class AdminCategories extends StatefulWidget {
  AdminCategories({super.key});

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  TextEditingController title = TextEditingController();

  final db = FirebaseFirestore.instance.collection('categories');

  bool isLoading = false;

 Future UpdateCategory(context,id) async {
    setState(() {
      isLoading = true;
    });
    try {
     
      db.doc(id.toString()).update({
        "categoryTitle":title.text
      });
      title.clear();
      Navigator.pop(context);
    } catch (e) {
      Utils.showMessage(context, e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future addCategory(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final key = DateTime.now().millisecondsSinceEpoch;
      await db.doc(key.toString()).set({
        "categoryId": key,
        "categoryTitle": title.text,
      });
      title.clear();
      Navigator.pop(context);
    } catch (e) {
      Utils.showMessage(context, e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
Future deleteCategory(id) async{
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
      appBar: Utils.customAppBar("C A T E G O R I E S  L I S T"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Category"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextfield(label: "title", controller: title),
                  ],
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
                  isLoading
                      ? CircularProgressIndicator(color: Colors.amber[300])
                      : ElevatedButton(
                          onPressed: () => addCategory(context),
                          child: Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber[300],
        foregroundColor: Colors.black,
      ),

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
              final category=data[index].data();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4)),
                  tileColor: const Color.fromARGB(174, 255, 236, 179),
                        title: Text("${index+1}.\t\t${category['categoryTitle']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                               showDialog(
                                context: context, 
                                builder: (context) {
                               title.text=   category['categoryTitle'];
                                 return AlertDialog(
                title: Text("Edit Category"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextfield(label: "title", controller: title),
                  ],
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
                  isLoading
                      ? CircularProgressIndicator(color: Colors.amber[300])
                      : ElevatedButton(
                          onPressed: ()=>UpdateCategory(context, category['categoryId']),
                          child: Text("Update"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                ],
              );
                                },);
                            },visualDensity: VisualDensity.compact, icon: FaIcon(FontAwesomeIcons.pen,size:16, color: Colors.black,)),
                            IconButton(onPressed:() {
                              showDialog(context: context, builder: (context) {
                                            return AlertDialog(
                                              title: Center(child: Text("Are You Sure?"),),
                                              content: Text("This action will permanently delete ' ${category['categoryTitle']} ' from categories."),
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
                                  onPressed: () => deleteCategory(category['categoryId']),
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
