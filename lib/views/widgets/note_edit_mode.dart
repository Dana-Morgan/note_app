import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';


class EditNoteDetails extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const EditNoteDetails({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ListView(
        children: [
          TextField(
            controller: titleController,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'title',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: contentController,
              style: TextStyle(fontSize: 18, color: Colors.brown.shade900),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'content',
              ),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
