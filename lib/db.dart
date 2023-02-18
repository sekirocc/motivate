import 'package:flutter/material.dart';

import 'model.dart';

class NotebookDBModel extends ChangeNotifier {
  late NotebooksModel _notebooksModel;
  late NotesModel _notesModel;

  late Map<String, Map<String, String>> _data;

  int _selectedNotebook = -1;
  int _selectedNote = -1;

  NotebookDBModel(data) {
    _data = data;
    rebuildModels(0, 0);
  }

  int get selectedNotebook => _selectedNotebook;
  int get selectedNote => _selectedNote;

  void selectNotebook(int index) {
    rebuildModels(index, 0);
  }

  void selectNote(int index) {
    rebuildModels(_selectedNotebook, index);
  }

  NotebooksModel get notebooks => _notebooksModel;
  NotesModel get notes => _notesModel;

  void rebuildModels(int selectedNotebook, int selectedNote) {
    _selectedNotebook = selectedNotebook;
    _selectedNote = selectedNote;

    NotebooksModel model1 = NotebooksModel();
    NotesModel model2 = NotesModel();

    List<String> notebookKeys = _data.keys.toList(growable: false);
    for (int i = 0; i < notebookKeys.length; i++) {
      var element = notebookKeys[i];
      model1.add(Notebook(element));
    }

    if (notebookKeys.isNotEmpty && selectedNotebook >= 0) {
      List<String> noteKeys =
          _data[notebookKeys[selectedNotebook]]!.keys.toList();
      for (int i = 0; i < noteKeys.length; i++) {
        var element = noteKeys[i];
        model2.add(Note(element));
      }
    }

    _notebooksModel = model1;
    _notesModel = model2;

    notifyListeners();
  }
}
