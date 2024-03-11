

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class internetexception extends StatefulWidget {

  const internetexception({Key? key,}) : super(key: key);

  @override
  State<internetexception> createState() => _internetexceptionState();
}

class _internetexceptionState extends State<internetexception> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Icon(Icons.cloud_off, color: Colors.red
            ,
          size: 50,),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Center(child: Text('interenet exception',
                style: Theme.of(context).textTheme
                .bodyLarge)),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              // onTap: widget.onpress,
              child: Container(
                height: 50,width: 160,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text('Retry', style: Theme.of(context).textTheme
                    .titleLarge!.copyWith(color: Colors.white70),)),
              ),
            ),
          )
        ],

      ),
    );
  }
}
