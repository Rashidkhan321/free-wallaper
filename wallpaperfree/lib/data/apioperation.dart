// install http
import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:wallpaperfree/components/internetexception.dart';
import 'package:wallpaperfree/modalview/Apimodal.dart';

import '../modalview/cate.dart';
import 'appexceptions.dart';
class ApiModal extends GetxController{

 Future<List<DataModal>> getdata() async{
   try{
     var imagelist = <DataModal>[].obs;


     await  http.get(Uri.parse('https://api.pexels.com/v1/search?query=mobile wallpaper&per_page=80'),
         headers: {
           "Authorization":"tpQFxyNxC3gJOCb6XBukh0zLXjEBycmnekYdRXcpOW7sASk1sLIAWRC5"
         }
     ).timeout(Duration(minutes: 1)).then((value){

       Map<String, dynamic> jsondata = jsonDecode(value.body);
       List data = jsondata["photos"];

       data.forEach((element) {
         imagelist.add(DataModal.ModalFunction(element));
       });
       return imagelist;
     });
     return imagelist;

   }

   on TimeoutException{
     throw RequestTimeout();
   }
   on SocketException{
   throw  InternetException();
   }
   on ServerSideException{
     throw ServerSideException();
   }





  }


 //lets go for serach
 var serachlist =<DataModal>[].obs;


Future<List<DataModal>> getSerachdata(String query) async{
  try{
    await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=80'),
        headers: {
          "Authorization":"tpQFxyNxC3gJOCb6XBukh0zLXjEBycmnekYdRXcpOW7sASk1sLIAWRC5"
        }).timeout(Duration(minutes: 1)).then((value) {

      Map<String, dynamic> jasondata =jsonDecode(value.body);
      List data = jasondata['photos'];
      serachlist.clear();
      data.forEach((element) {
        serachlist.add(DataModal.ModalFunction(element));


      });

      return serachlist;
    });
    return serachlist;
  }
  on TimeoutException{

    throw RequestTimeout();
  }
  on SocketException{

    throw InternetException();

  }
  on ServerSideException{
    throw ServerSideException();
  }



}


var categorylist =<catmodal>[].obs;

List<catmodal> getcategorybase(){

  List catitems=[
    'Car',
    'Animal',
    'City',
    'Country',
    'Flowers',
    'Nature'

  ];
  
  catitems.forEach((element) async {
    final value = new Random();

    DataModal modal =(await getSerachdata(element))[0+value.nextInt(6-0)];

    categorylist.add(catmodal(url: modal.Url, name: element));

  });
return categorylist;
}

var carmodal=<catmodal>[].obs;
List<catmodal> getcarlist(){
  List caritems =[
    'BMW',
    'Toyota',
    'Hyundai',
    'SAIC',
    'Ferrari',
    'Honda',
    'Tesla'
  ];
  caritems.forEach((element) async{
    final value = new Random();
    DataModal modal =(await getSerachdata(element))[0+value.nextInt(8-1)];
    carmodal.add(catmodal(url: modal.Url, name: element));
  });
  return carmodal;
}
var  flowermodal=<catmodal>[].obs;
List<catmodal> getflower(){
  List floweritems=[
    'Rose',
    'waterlily'
    'Sunflower',
    'Petunia',
    'Winter Viola',
    'Peony',
    'Lilac bush'

  ];
  floweritems.forEach((element) async{
    final value = new Random();
    DataModal modal=(await getSerachdata(element))[0+value.nextInt(7-0)];
    flowermodal.add(catmodal(url: modal.Url, name: element));
  });
  return flowermodal;
}
var animalmodal=<catmodal>[].obs;
List<catmodal> getanimal(){
  List animalitems=[
    'Tiger',
    'Lion',
    'Cate',
    'Wolf',
    'Buterfly',
    'Rabbit',
    'Fox',
    'Dolphin',


  ];
  animalitems.forEach((element) async{
    final value = new Random();
    DataModal modal = ( await getSerachdata(element))[0+value.nextInt(8-0)];
    animalmodal.add(catmodal(url: modal.Url, name: element));
  });
  return animalmodal;

}
var citmodal=<catmodal>[].obs;
List<catmodal> getcitymodal(){
  List cityitem=[
    'Sydney',
    'Barcelona',
    'Queenstown',
    'Istanbul',
    'Paris',
    'Cape Town',
    'Seoul',
    'Kyoto',
    'Tbilisi'
  ];

  cityitem.forEach((element) async{
    final value = new Random();
    DataModal modal =(await getSerachdata(element))[0+value.nextInt(10-0)];
    citmodal.add(catmodal(url: modal.Url, name: element));

  });
  return citmodal;
}

var courtymodal=<catmodal>[].obs;
List<catmodal> getcountry(){

  List courtyitem =[
    'Maldives',
    'Costa Rica',
    'United States',
    'Peru',
    'Japan',
    'Iceland',
    'Kenya',
    'Namibia',
    'Greece',
  ];

  courtyitem.forEach((element) async{
    final value = new Random();
    DataModal modal  =( await getSerachdata(element))[0+value.nextInt(10-1)];
    courtymodal.add(catmodal(url: modal.Url, name: element));
  })
  ;
  return courtymodal;
}


var nature = <catmodal>[].obs;
List<catmodal> getnaure() {
  List natureitem =[
    'Spring',
    'Grass',
    'Summer',
    'River',
    'Graden',
    'Tree',
    'Water',
    'Mountain',
    'Iceland',
    'Landscape',


  ];
  natureitem.forEach((element) async{
    final value = new Random();
    DataModal modal =(await getSerachdata(element))[0+value.nextInt(10-0)];
    nature.add(catmodal(url: modal.Url, name: element));

  });
  return nature;
}

}
