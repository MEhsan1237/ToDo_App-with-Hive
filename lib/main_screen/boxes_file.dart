

import 'package:hive/hive.dart';
import 'package:hive_project/notes_model/notes_model.dart';

class Boxes    {

  static Box<NotesModel> getData()=> Hive.box("notes");

}