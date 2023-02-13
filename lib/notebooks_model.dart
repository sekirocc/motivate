import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notebook {
  String name = "";

  Notebook(String s) {
    name = s;
  }
}

class NotebooksModel extends ChangeNotifier {
  final List<Notebook> _notebooks = [
    Notebook("book1"),
    Notebook("book2"),
    Notebook("book3")
  ];
  int _selected = -1;

  int get selected => _selected;
  int get count => _notebooks.length;

  List<Notebook> get items => _notebooks;

  void add(Notebook item) {
    _notebooks.add(item);
    notifyListeners();
  }

  void select(int index) {
    _selected = index;
  }
}

class Note {}

class NotesModel extends ChangeNotifier {
  final List<Note> _notes = [];
  int _selected = -1;

  int get selected => _selected;
  int get count => _notes.length;

  void add(Note item) {
    _notes.add(item);
    notifyListeners();
  }

  void select(int index) {
    _selected = index;
  }
}
