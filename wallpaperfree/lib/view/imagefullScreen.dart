
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:open_file/open_file.dart';

class fullScreen extends StatefulWidget {
  final imageurl;
  const fullScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  State<fullScreen> createState() => _fullScreenState();
}

class _fullScreenState extends State<fullScreen> {
  bool loading = false;

 // download image code
   //set the wallpaper
  //import these

  void saveimage() async{
    loading =true;
    await GallerySaver.saveImage(widget.imageurl).then((value) {

      setState(() {
        loading =true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloaded')));
    }).then((value) {
      setState(() {
        loading =false;
      });

      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Container(
            height: 200,
            width: 100,
            child: Column(
              children: [

                ListTile(
                  onTap: ()async{
                    Navigator.pop(context);
                    int location =WallpaperManager.LOCK_SCREEN;

                    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
                    await WallpaperManager.setWallpaperFromFile(file.path, location);
                  },
                  title: Text('Set to look screen'),
                ),
                ListTile(
                  onTap: ()async{
                    Navigator.pop(context);
                    int location =WallpaperManager.HOME_SCREEN;

                    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
                    await WallpaperManager.setWallpaperFromFile(file.path, location);
                  },
                  title: Text('Set to home screen'),
                ),
                ListTile(
                  onTap: ()async{
                    Navigator.pop(context);
                    int location =WallpaperManager.BOTH_SCREEN;

                    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
                    await WallpaperManager.setWallpaperFromFile(file.path, location);
                  },
                  title: Text('Set as both'),
                )
              ],
            ),
          ),
        );
      }
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: ElevatedButton(
          onPressed: () {
           saveimage();

          },
          child: loading?Center(child: CircularProgressIndicator(),):Text("Set Wallpaper")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imageurl), fit: BoxFit.cover)),
      ),
    );
  }


}




