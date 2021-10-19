import 'package:flutter/material.dart';
import 'package:fasting_diary/Notes/Notes.dart';

class NoteOperation extends ChangeNotifier{
  List<Note> _note = <Note>[];

  List <Note> get getNotes{
    return _note;
  }
  NoteOperation()
  {
    addNewNode('First Note', 'First Note Description');
  }
  void addNewNode(String title, String description)
  {
    Note note = Note(title, description);
    _note.add(note);
    notifyListeners();
  }
}