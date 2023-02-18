import 'package:flutter/material.dart';

class Notebook {
  String name = "";

  Notebook(String s) {
    name = s;
  }
}

class NotebooksModel {
  final List<Notebook> _notebooks = [];
  int _selected = 0;

  int get selected => _selected;
  int get count => _notebooks.length;

  List<Notebook> get items => _notebooks;

  void add(Notebook item) {
    _notebooks.add(item);
  }

  void select(int index) {
    _selected = index;
  }

  Notebook get(int index) {
    return _notebooks[index];
  }
}

class Note {
  String title = "";
  String created_at = "";

  Note(String t) {
    title = t;
  }
}

class NotesModel {
  final List<Note> _notes = [];
  int _selected = 0;

  int get selected => _selected;
  int get count => _notes.length;

  List<Note> get items => _notes;

  void add(Note item) {
    _notes.add(item);
  }

  void select(int index) {
    _selected = index;
  }

  Note get(int index) {
    return _notes[index];
  }
}
