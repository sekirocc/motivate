import 'package:flutter/material.dart';

class NotebookDBModel extends ChangeNotifier {
  late Notebooks _notebooksModel;
  late Notes _notesModel;
  Note _noteModel = Note("", "");

  late Map<String, Map<String, String>> _data;

  int _selectedNotebook = -1;
  int _selectedNote = -1;

  NotebookDBModel(data) {
    _data = data;
    rebuildModels(0, 0);
  }

  int get selectedNotebook => _selectedNotebook;
  int get selectedNote => _selectedNote;

  Notebooks get notebooks => _notebooksModel;
  Notes get notes => _notesModel;
  Note get note => _noteModel;

  void selectNotebook(int index) {
    rebuildModels(index, 0);
  }

  void selectNote(int index) {
    rebuildModels(_selectedNotebook, index);
  }

  void rebuildModels(int selectedNotebook, int selectedNote) {
    _selectedNotebook = selectedNotebook;
    _selectedNote = selectedNote;

    Notebooks model1 = Notebooks();
    Notes model2 = Notes();

    List<String> notebookKeys = _data.keys.toList(growable: false);
    for (int i = 0; i < notebookKeys.length; i++) {
      var element = notebookKeys[i];
      model1.add(Notebook(element));
    }

    if (notebookKeys.isNotEmpty && selectedNotebook >= 0) {
      var notebookKey = notebookKeys[selectedNotebook];
      var notes = _data[notebookKey]!;
      List<String> noteKeys = notes.keys.toList();
      for (int i = 0; i < noteKeys.length; i++) {
        var noteKey = noteKeys[i];
        var note = Note(noteKey, notes[noteKey]!);
        if (i == selectedNote) {
          _noteModel = note;
        }
        model2.add(note);
      }
    }

    _notebooksModel = model1;
    _notesModel = model2;

    notifyListeners();
  }
}

class Notebook {
  String name = "";

  Notebook(String s) {
    name = s;
  }
}

class Notebooks {
  final List<Notebook> _notebooks = [];
  int get count => _notebooks.length;

  List<Notebook> get items => _notebooks;

  void add(Notebook item) {
    _notebooks.add(item);
  }

  Notebook get(int index) {
    return _notebooks[index];
  }
}

class Note {
  String title = "";
  String content = "";
  String created_at = "";

  Note(String t, String c) {
    title = t;
    content = c;
  }
}

class Notes {
  final List<Note> _notes = [];
  int get count => _notes.length;

  List<Note> get items => _notes;

  void add(Note item) {
    _notes.add(item);
  }

  Note get(int index) {
    return _notes[index];
  }
}
