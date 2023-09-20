

import 'package:flutter/material.dart';
import 'package:offline_data_base/edit.dart';
import 'package:offline_data_base/main.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map> l=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String sql="select * from test";
    Home.database!.rawQuery(sql).then((value){
      l=value;
      setState(() {

      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("view"),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Home();
            },));
          }, icon: Icon(Icons.home))

        ],
      ),
      body: ListView.builder(itemCount: l.length,
        itemBuilder: (context, index) {
          return Card(child:
          ListTile(

            title: Text("${l[index]['name']}"),
            subtitle: Text("${l[index]['contact']}\n${l[index]['gmail']}"),

            trailing: Wrap(children: [
              IconButton(onPressed: () {
                String qry="delete from test where id ='${l[index]['id']}'";
                Home.database!.rawDelete(qry);
                setState(() {

                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return view();
                },));
              }, icon: Icon(Icons.delete)),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return edit(l[index]);
                },));

              }, icon: Icon(Icons.edit)),

            ],),
          ),);
        },),
    );
  }
}