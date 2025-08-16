import 'package:note_app/models/note.dart';

class NoteRepository {

  final List<Note> notes = [];

  static final NoteRepository _instance = NoteRepository._internal();
  factory NoteRepository() {
    return _instance;
  }

  NoteRepository._internal();

  void addNote(Note note) {
    notes.add(note);
  }


  void updateNote(Note newNote, Note oldNote) {
    int index = notes.indexWhere((note) => note == oldNote);
    if (index != -1) {
      notes[index] = newNote;
    }
   }

}