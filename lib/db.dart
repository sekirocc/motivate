import 'model.dart';

class NotebookDB {
  late NotebooksModel _notebooksModel;
  late NotesModel _notesModel;

  NotebookDB(Map<String, Map<String, String>> data) {
    NotebooksModel model1 = NotebooksModel();
    NotesModel model2 = NotesModel();

    List<String> notebookKeys = data.keys.toList(growable: false);
    for (var element in notebookKeys) {
      model1.add(Notebook(element));
    }
    if (notebookKeys.isNotEmpty) {
      List<String> noteKeys = data[notebookKeys.first]!.keys.toList();
      for (var element in noteKeys) {
        model2.add(Note(element));
      }
    }

    _notebooksModel = model1;
    _notesModel = model2;
  }

  NotebooksModel notebooks() {
    return _notebooksModel;
  }

  NotesModel notes() {
    return _notesModel;
  }
}
