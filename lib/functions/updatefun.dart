


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_project/provider/provider_class.dart';

import '../notes_model/notes_model.dart';

Future updateMyDialogue(BuildContext context,NotesModel notesModel , String title , String description,) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  ThemeProvider themeProvider = ThemeProvider();
  titleController.text = title;
  descriptionController.text= description;
  return showDialog(
    context: context,
    builder: ( BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        title: Text(

          "Update the Document",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        content: Column(  mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 6),
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
                onPressed: () async{

                  notesModel.title = titleController.text.toString();
                  notesModel.description = descriptionController.text.toString();
                  await  notesModel.save();
                  descriptionController.clear();
                  titleController.clear();
                  Navigator.pop(context);

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

