


import 'package:flutter/material.dart';
import 'package:hive_project/provider/provider_class.dart';
import 'package:hive_project/utils/toast_message.dart';
import '../main_screen/boxes_file.dart';
import '../notes_model/notes_model.dart';



Future showMyDialogue(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  ThemeProvider themeProvider = ThemeProvider();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(


        backgroundColor: Theme.of(context).dialogBackgroundColor,


        title: Center(
          child: Text(

            "Add the Document",
            style: TextStyle(color: Colors.black),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: TextFormField(
                style: TextStyle(
                  color: themeProvider.isDarkMode? Colors.black: Colors.black
                ),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Add the Title",


                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple,width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: TextFormField(
                style: TextStyle(
                    color: themeProvider.isDarkMode? Colors.black: Colors.black
                ),
                maxLines: 2,
                controller: descriptionController,
                decoration: InputDecoration(

                  hintText: "Add the Description",
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple,width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Center(child: Text("Cancel")),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  var data = NotesModel(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  var box = Boxes.getData();
                  box.add(data);
                  data.save();

                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                  ToastMessage().message("Added successfully");
                },
                child: Center(child: Text("Add")),
              ),

            ],
          ),
        ],
      );
    },
  );
}
