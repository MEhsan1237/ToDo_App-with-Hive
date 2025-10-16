import '../notes_model/notes_model.dart';

void delete(NotesModel notesModel)async{
  await notesModel.delete();
}

