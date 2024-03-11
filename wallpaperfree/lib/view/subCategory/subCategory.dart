import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaperfree/view/subCategory/subCatDetail.dart';


class subcategory extends StatefulWidget {
  final catname , imageurl;
  const subcategory({Key? key, required this.catname, required this.imageurl}) : super(key: key);

  @override
  State<subcategory> createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {
  @override
  Widget build(BuildContext context) {
    return Container(



      child:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>subCatdetail(

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
                child: Text(widget.catname, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),))
          ],
        ),
      ),


    );
  }
}
class cat extends StatelessWidget {

  final imageurl;
  final imagpet;
  double   height;
  double width;


  cat({Key? key,
    required this.imageurl,
    required this.imagpet,
    this.height=50,this.width=100,

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


            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [


                  Container(
                      margin: EdgeInsets.only(bottom: 13),
                      child: Text('!'))
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}


