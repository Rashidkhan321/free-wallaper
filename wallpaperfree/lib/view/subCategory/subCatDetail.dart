
//steps:
//copypast the homescreen
//remove the category section
//remove the serach bar

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaperfree/components/SerachBar.dart';
import 'package:wallpaperfree/components/categories.dart';
import 'package:wallpaperfree/components/customappbar.dart';
import 'package:wallpaperfree/modalview/Apimodal.dart';
import 'package:wallpaperfree/view/homeScreen.dart';
import 'package:wallpaperfree/view/imagefullScreen.dart';
import 'package:wallpaperfree/view/subCategory/subCategory.dart';

import '../../data/apioperation.dart';


class subCatdetail extends StatefulWidget {
  final image, name;

  const subCatdetail({Key? key, required this.image, required this
      .name}) : super(key: key);

  @override
  State<subCatdetail> createState() => _subCatdetailState();
}

class _subCatdetailState extends State<subCatdetail> {
  bool loading = true;

  List<DataModal> list =[];
  List<catmodal> getcatlist=[];
  getcategry() async{

    list = await ApiModal().getSerachdata(widget.name);
    setState(() {
      loading = false;

    });
  }

  @override
  void initState() {

    getcategry();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:loading?Center(child: CircularProgressIndicator(),):
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                ClipRRect(

                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child:

                    Image.network(widget.image

                      ,fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 1,
                    top: 1,
                    right: 1,
                    left: 1,

                    child: Center(child: Text(widget.name,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),)))

              ],
            ),
          ),




          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.builder(


                  itemCount: list.length,
                  crossAxisSpacing: 3,mainAxisSpacing: 3,

                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2
                  ), itemBuilder:
                  (context, index){
                List<double> itemhight = [380, 300, 320, 200];
                double hights = itemhight[index% itemhight.length];

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>fullScreen(imageurl: list[index].Url )));
                  },
                  child: Container(
                      height: hights,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.green,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child:

                        imagepick(
                          imageurl: list[index].Url, imagpet: BoxFit.cover,)

                      ) ),
                );
              }),
            ),
          )
        ],
      ),

    );
  }
}
