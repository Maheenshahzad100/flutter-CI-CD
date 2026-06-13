import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maheen_flutter_practice/utils/utils.dart';
class CustomCarouselSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}



class _CarouselWithIndicatorState extends State<CustomCarouselSlider> {
    List imgList=[];
  int _current = 0;

void getImages(context)async{
  try{
    final db=await FirebaseFirestore.instance.collection('products').get();
setState((){imgList=db.docs;});

  }
  catch(e){
    Utils.showMessage(context, e.toString());
  }
}
  @override
  void initState() {
    // TODO: implement initState
    getImages(context);
    super.initState();
  }
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
    .map((item) => Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: Container(
            child: Container(
              
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.data()['imageUrl'], fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '${item.data()['name']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
    ))
    .toList();
    return  Column(children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
       
      ]);
    
  }
}