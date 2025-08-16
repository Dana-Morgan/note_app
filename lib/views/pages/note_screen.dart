import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/views/widgets/note_edit_mode.dart';
import '../../repositories/note_repository.dart';
import '../../models/note.dart';
import '../widgets/action_icon.dart';
import '../widgets/note_display_mode.dart';

class NotePage extends StatefulWidget {
  NotePage({super.key, required this.note, this.isEdit = false});
  final Note note;
  bool isEdit;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late Note currentNote;
  final noteRepo = NoteRepository();

  @override
  void initState() {
    super.initState();
    currentNote = widget.note;
    titleController = TextEditingController(text: currentNote.title);
    contentController = TextEditingController(text: currentNote.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void saveNote() {
    final sameTitle = titleController.text == currentNote.title;
    final sameContent = contentController.text == currentNote.content;

    if (sameTitle && sameContent && currentNote.isSaved) {
      setState(() {
        widget.isEdit = false;
      });
      return;
    }

    final updatedNote = currentNote.copyWith(
      title: titleController.text,
      content: contentController.text,
      isSaved: true,
    );

    if (!currentNote.isSaved) {
      noteRepo.addNote(updatedNote);
    } else {
      noteRepo.updateNote(updatedNote, currentNote);
    }

    setState(() {
      currentNote = updatedNote;
      widget.isEdit = false;
    });
  }


  IconData get pinIcon =>
      currentNote.isPinned ? Icons.push_pin : Icons.push_pin_outlined;

  IconData get editIcon =>
      widget.isEdit ? Icons.mode_edit : Icons.mode_edit_outline_outlined;

  void pinNote() {
    final updatedNote = currentNote.copyWith(isPinned: !currentNote.isPinned);
    noteRepo.updateNote(updatedNote, currentNote);
    setState(() {
      currentNote = updatedNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () {
              context.goNamed('home');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
          actions: [
            if (widget.isEdit)
              ActionIcon(
                icon: Icons.save_outlined,
                onPressed: () {
                  saveNote();
                },
              )
            else ...[
              ActionIcon(
                icon: editIcon,
                onPressed: () {
                  setState(() {
                    widget.isEdit = true;
                  });
                },
              ),
              ActionIcon(
                icon: pinIcon,
                onPressed: () {
                  pinNote();
                },
              ),
              ActionIcon(
                icon: Icons.delete_outline,
                onPressed: () {
                  noteRepo.notes.removeWhere((n) => n.id == currentNote.id);
                  context.goNamed('home');
                },
              ),
            ],
          ],
      ),
      body: !widget.isEdit
          ? DisplayNoteDetails(currentNote: currentNote)
          : EditNoteDetails(
              titleController: titleController,
              contentController: contentController,
            ),
    );
  }
}
