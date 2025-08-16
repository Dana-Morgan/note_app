import 'package:go_router/go_router.dart';
import 'package:note_app/views/pages/note_screen.dart';
import 'package:note_app/models/note.dart';

import '../views/pages/notes_list_screen.dart';

class ScreenPaths {
  static const String notesList = '/';
  static const String note = '/note';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: ScreenPaths.notesList,
      name: 'home',
      builder: (context, state) => NotesListPage(),
    ),
    GoRoute(
      path: '/note/:mode',
      name: 'note',
      builder: (context, state) {
        final note = state.extra as Note;
        final isEdit = state.pathParameters['mode'] == 'edit';
        return NotePage(note: note, isEdit: isEdit);
      },
    ),

  ],
);
