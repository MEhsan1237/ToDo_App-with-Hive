import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/main_screen/boxes_file.dart';
import 'package:hive_project/notes_model/notes_model.dart';

import '../functions/deletefun.dart';
import '../functions/showdialogue_fun.dart';
import '../functions/updatefun.dart';


class MyAppHive extends StatefulWidget {
  const MyAppHive({super.key});

  @override
  State<MyAppHive> createState() => _MyAppHiveState();
}

class _MyAppHiveState extends State<MyAppHive> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App", style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          showMyDialogue(context);
        },
        child: Icon(Icons.add, size: 26,),
      ),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 4),
              itemCount: box.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .12,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .14,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text(
                                  data[index].title.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                  overflow: TextOverflow.ellipsis,)),
                                Spacer(),
                                InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: Icon(Icons.delete)),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        updateMyDialogue(context, data[index],
                                          data[index].title.toString(),
                                          data[index].description.toString(),);
                                      });
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data[index].description.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              maxLines: 2,
                              // jitni lines dikhani hain
                              overflow: TextOverflow.ellipsis,
                              // dots last me dikhaye
                              softWrap: true, // wrap allow kare
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },);
        },),
    );
  }

}