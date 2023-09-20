
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline_data_base/view.dart';

import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Home(),));
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static Database ?database;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    getsql();
    get_permission();
  }

  getsql()
  async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Home.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,contact TEXT,gmail TEXT)');
        });

  }
  get_permission() async {
    var status = await Permission.camera.status;
    var status1 = await Permission.storage.status;

    if (status.isDenied && status1.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  bool is_images = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Sqlite"),),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t1,decoration: InputDecoration(labelText: "Enter Name"),)),
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t2,decoration: InputDecoration(labelText: "Enter Contact"))),
          Card(color: Colors.grey,margin: EdgeInsets.all(5),child: TextField(controller: t3,decoration: InputDecoration(labelText: "Enter Email"))),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Upload image"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                image = await picker.pickImage(
                                    source: ImageSource.camera);
                                is_images = true;
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: Text("Camera")),
                          TextButton(
                              onPressed: () async {
                                image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                is_images = true;
                                Navigator.pop(context);

                                setState(() {});
                              },
                              child: Text("Gallery")),
                        ],
                      );
                    });
              },
              child: Text("Upload image")),
          Container(
            height: 100,
            width: 100,
            child: (is_images)
                ? Image.file(File(image!.path))
                : Icon(Icons.account_circle_outlined),
          ),
          ElevatedButton(onPressed: () {
            String name=t1.text;
            String contact=t2.text;
            String email=t3.text;
            String sql="insert into test values(null,'$name','$contact','$email')";
            Home.database!.rawInsert(sql);
            setState(() {

            });
            print(sql);
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