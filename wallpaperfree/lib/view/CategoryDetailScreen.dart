//steps:
//copypast the homescreen
//remove the category section
//remove the serach bar

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaperfree/components/SerachBar.dart';
import 'package:wallpaperfree/components/categories.dart';
import 'package:wallpaperfree/components/customappbar.dart';
import 'package:wallpaperfree/modalview/Apimodal.dart';
import 'package:wallpaperfree/view/imagefullScreen.dart';
import 'package:wallpaperfree/view/subCategory/subCategory.dart';

import '../components/example.dart';
import '../data/apioperation.dart';

class CategoryDetail extends StatefulWidget {
  final image, name;

  const CategoryDetail({Key? key, required this.image, required this
  .name}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final controller = Get.put(ApiModal());
  bool loading = true;

  List<DataModal> list =[];
  List<catmodal> getcatlist=[];
  getcategry() async{

    list = await controller.getSerachdata(widget.name);
    setState(() {
      list=list;
      loading = false;

    });
  }
  getcategory()async {

    if(widget.name=='Car'){
    getcatlist =await controller.getcarlist();
    }
    else if(widget.name=='Animal'){
    getcatlist =await controller.getanimal();
    }
    else if(widget.name=='City'){
    getcatlist =await controller.getcitymodal();
    }
    else if(widget.name=='Country'){
    getcatlist =await controller.getcountry();
    }
    else if(widget.name=='Flowers'){
    getcatlist =await controller.getflower();
    }
    else if(widget.name=='Nature'){
      getcatlist =await controller.getnaure();
    }

    setState(() {
      getcatlist=getcatlist;
    });

  }
  @override
  void initState() {
    getcategory();
    getcategry();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:loading?Center(child: CircularProgressIndicator(),):
    Obx(() =>   Column(
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
                  child: Image.network(widget.image

                    ,fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child:
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: getcatlist.length,
                        itemBuilder: (context,index){
                          return subcategory(
                            catname: getcatlist[index].name, imageurl: getcatlist[index].url,);
                        }),
                  ),

                ),
              )

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


                      Image.network(
                          fit:BoxFit.cover,
                          list[index].Url ),
                    ) ),
              );
            }),
          ),
        )
      ],
    ),)
      
    );
  }
}
