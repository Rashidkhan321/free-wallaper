
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaperfree/data/apioperation.dart';
import 'package:wallpaperfree/modalview/Apimodal.dart';
import 'package:wallpaperfree/view/homeScreen.dart';

import 'imagefullScreen.dart';

class SerachScreen extends StatefulWidget {
  String query;
  SerachScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  bool loading = true;
  final serachcontroller = TextEditingController();

  List<DataModal> serachlist =[];

  getserachwallpaper() async{
    serachlist= await ApiModal().getSerachdata(widget.query);
    setState(() {
      loading = false;

    });

  }

  @override
  void initState() {
    getserachwallpaper();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: loading?Center(child: CircularProgressIndicator(),):Column(
        children: [
          SizedBox(height: 70,),
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all()
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(

                  controller: serachcontroller,
                  decoration: InputDecoration(
                    hintText: 'serach...',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,

                  ),
                ),
              ),
              InkWell(
                  onTap: (){
                    if(serachcontroller.text==''){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Serach is empty')));
                    }
                    else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:
                          (context)=>SerachScreen(query: serachcontroller.text)));

                    }
                    },
                  child: Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:

                MasonryGridView.builder(


                    itemCount: serachlist.length,
                    crossAxisSpacing: 3,mainAxisSpacing: 3,

                    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                    ), itemBuilder:
                    (context, index){
                  List<double> itemhight = [380, 300, 320, 200];
                  double hights = itemhight[index% itemhight.length];

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>fullScreen(imageurl: serachlist[index].Url )));
                    },
                    child: Container(
                        height: hights,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.green,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: imagepick(imageurl:
                            serachlist[index].Url, imagpet:  BoxFit.cover,)
                        )
                    ),
                  );

                }),
              )
          )
        ],
      ),
    );
  }
}
