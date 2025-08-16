import 'dart:math';

import 'package:flutter/material.dart';

class Note {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isPinned;
  final Color? noteColor;
  bool isSaved;
  static int counter=0;

  Note({
    this.title = '',
    this.content = '',
    DateTime? createdAt,
    this.updatedAt,
    this.isPinned = false,
    this.isSaved = false
  })  : createdAt = createdAt ?? DateTime.now(),
        noteColor = chooseColor(),
        id = ++counter;


// add this to theme
  static final List<Color> cardColors = [
    Colors.orange.shade50,
    Colors.orange.shade100,
    Colors.orange.shade200,
    Colors.brown.shade200,
    Colors.brown.shade100,
    Colors.red.shade50,
    Colors.red.shade100,
    Colors.red.shade200,
    Colors.amber.shade50,
    Colors.amber.shade100,
    Colors.amber.shade200,
    Colors.deepOrange.shade50,
    Colors.deepOrange.shade100,
    Colors.deepOrange.shade200,
    Colors.yellow.shade50,
    Colors.yellow.shade100,
  ];

  static Color chooseColor() {
    final random = Random();
    Color color = cardColors[random.nextInt(cardColors.length)];
    return color;
  }

  Note copyWith({
    String? title,
    String? content,
    bool? isSaved,
    bool? isPinned,
  }) {
    return Note(
      title: title ?? this.title,
      isPinned: isPinned ?? this.isPinned,
      isSaved: isSaved ?? this.isSaved,
      content: content ?? this.content,
      updatedAt: DateTime.now(),

    );
  }
}