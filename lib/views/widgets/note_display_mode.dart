import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

import 'note_card.dart';

class DisplayNoteDetails extends StatelessWidget{
  const DisplayNoteDetails({super.key, required this.currentNote});
  final Note currentNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            currentNote.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade800,
            ),
          ),
          if (currentNote.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentNote.content,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown.shade900,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}