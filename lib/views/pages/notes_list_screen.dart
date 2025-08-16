import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/views/widgets/note_card.dart';
import 'package:note_app/repositories/note_repository.dart';

class NotesListPage extends StatefulWidget {
  NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  final noteRepo = NoteRepository();
  final TextEditingController _searchController = TextEditingController();

  bool isSearchClicked = false;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final notes = noteRepo.notes;

    final filteredNotes = notes.where((note) {
      return note.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: isSearchClicked
            ? Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
              contentPadding:
              EdgeInsets.only(left: 16, bottom: 2),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Search..',
            ),
          ),
        )
            : const Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isSearchClicked = !isSearchClicked;
                    if (!isSearchClicked) {
                      _searchController.clear();
                      searchText = "";
                    }
                  });
                },
                icon: Icon(
                  isSearchClicked ? Icons.close : Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          context.goNamed(
            'note',
            pathParameters: {'mode': 'edit'},
            extra: Note(),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text('Pinned Notes', style: TextStyle(fontSize: 25)),
            ),
            if (filteredNotes.where((n) => n.isPinned).isEmpty)
              const Center(
                child: Text(
                  'No Pinned Notes',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...filteredNotes
                  .where((note) => note.isPinned)
                  .map((note) => NoteCard(note: note)),

            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 10),
              child: Text('All Notes', style: TextStyle(fontSize: 25)),
            ),
            if (filteredNotes.where((n) => !n.isPinned).isEmpty)
              const Center(
                child: Text(
                  'No Notes Available',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ...filteredNotes
                  .where((note) => !note.isPinned)
                  .map((note) => NoteCard(note: note)),
          ],
        ),
      ),
    );
  }
}
