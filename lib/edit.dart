
import 'package:flutter/material.dart';
import 'package:offline_data_base/main.dart';
import 'package:offline_data_base/view.dart';


class edit extends StatefulWidget {
  Map l;
  edit(this.l);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    t1.text=widget.l['name'];
    t2.text=widget.l['contact'];
    t3.text=widget.l['gmail'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UPdate"),),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t1,decoration: InputDecoration(labelText: "Enter Name"),)),
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t2,decoration: InputDecoration(labelText: "Enter Contact"))),
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t3,decoration: InputDecoration(labelText: "Enter Email"))),

          ElevatedButton(onPressed: () {
            String name=t1.text;
            String contact =t2.text;
            String email=t3.text;
            if(widget.l!=null)
            {
              String sql="update test set name='$name',contact='$contact',gmail='$email' where id='${widget.l['id']}'";
              Home.database!.rawUpdate(sql);
              setState(() {

              });
            }

            setState(() {

            });
          }, child: Text("submit")),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
            },));
          }, child: Text("view"))


        ],),
      ),

    );
  }
}