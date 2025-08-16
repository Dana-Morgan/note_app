import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/note.dart';
import '../../router/router.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key,required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        'note',
        pathParameters: {'mode': 'display'},
        extra: note,
      )
      ,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Card(
              color: note.noteColor,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(note.title, style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
            if(note.isPinned)
            Positioned(top:2, right:2,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.push_pin_outlined, color: Colors.brown,),
            ))
          ],
        ),
      ),
    );
  }
}
