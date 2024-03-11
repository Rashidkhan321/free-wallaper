import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaperfree/components/SerachBar.dart';
import 'package:wallpaperfree/components/categories.dart';
import 'package:wallpaperfree/components/customappbar.dart';
import 'package:wallpaperfree/data/apioperation.dart';
import '../modalview/Apimodal.dart';
import 'imagefullScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller= Get.put(ApiModal());

List<DataModal> wallpaperlist=[];
List<catmodal> getcatlist=[];
bool loading = true;

getwallpaper() async{
  getcatlist =await controller.getcategorybase();
 wallpaperlist =  await controller.getdata();


 setState(() {
   getcatlist=getcatlist;
loading=false;
 });
}
  @override
  void initState() {

    //controller.loading.value;
  getwallpaper();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{

        return await showDialog<bool>(context: context, builder: (context){
          return AlertDialog(

            content: Text('Do you want to exit the app?'),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: Text('No')),
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: Text('Yes'))
            ],

          );

        })??false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(title: 'Free ', subtitle: 'Wallpapers',),
        ),

        body:loading?Center(child: CircularProgressIndicator(),):

          Obx(
              ()=> Column(
              children: [
                SerachBar(),
                SizedBox(height: 8,),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: getcatlist.length,
                        itemBuilder: (context,index){
                      return CategoryScreen(
                        catname: getcatlist[index].name, imageurl: getcatlist[index].url,);
                    }),
                  ),

                ),

                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:

                    RefreshIndicator(
                      onRefresh: () async {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: MasonryGridView.builder(


                      itemCount: wallpaperlist.length,
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
                              (context)=>fullScreen(imageurl: wallpaperlist[index].Url )));
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
                              imagepick(imageurl:  wallpaperlist[index].Url, imagpet: BoxFit.cover,)

                            )
                        ),
                      );

                                    }),
                    ),
                  )
                )
              ],
            ),
          ),

      ),
    );
  }
}
class imagepick extends StatelessWidget {

  final imageurl;
  final imagpet;
  double   height;
  double width;


  imagepick({Key? key,
    required this.imageurl,
    required this.imagpet,
    this.height = 400,
    this.width=900

  }) : super(key: key,

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Image(
        fit: imagpet,
        image: NetworkImage(imageurl),
        loadingBuilder: ( BuildContext context, Widget child, ImageChunkEvent? loading ){

          if(loading==null)
            return child;
          return Container(
            height: height,
            width: width,
            // MediaQuery.of(context).size.height *
            //    0.4,
            // width: MediaQuery.of(context).size.width *
            //   0.9,
            decoration: BoxDecoration(
                color: Colors.green.shade200
            ),
            child: Center(


               ),
          );
        },
        errorBuilder: (contex, exception, stack){
          return Container(
            decoration: BoxDecoration(
                color: Colors.green.shade200
            ),

            height:
            MediaQuery.of(context).size.height *
                0.3,
            width: MediaQuery.of(context).size.width *
                0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Icon(Icons.wifi_off, color: Colors.black,
                    size: 30,),
                  Container(
                      margin: EdgeInsets.only(bottom: 13),
                      child: Text('check internet connection!'))
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}