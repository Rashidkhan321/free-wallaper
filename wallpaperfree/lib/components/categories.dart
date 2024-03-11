import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../view/CategoryDetailScreen.dart';
import '../view/subCategory/subCategory.dart';
class CategoryScreen extends StatefulWidget {
   final catname , imageurl;
  const CategoryScreen({Key? key, required this.catname, required this.imageurl}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(



      child:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetail(

            image: widget.imageurl, name: widget.catname
            ,)));
        },
        child: Stack(
          children: [



            Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                cat(imageurl: widget.imageurl, imagpet: BoxFit.cover)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 50 ,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16)
                    ,
                    color: Colors.black26
                ),
              ),
            ),
            Positioned(
                left: 30,
                top: 20,
                child: Text(widget.catname,
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w600),))
          ],
        ),
      ),


    );
  }
}



