import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import '../appwrite_client.dart';
import '../models/note.dart';

Note _toNote(models.Row row) => Note(
      id: row.$id,
      title: row.data['title'] as String? ?? '',
      content: row.data['content'] as String? ?? '',
    );

// Lecture : uniquement les notes de l'utilisateur connecté
Future<List<Note>> listNotes() async {
  final user = await account.get();
  final result = await tablesDB.listRows(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    queries: [
      Query.equal('userId', user.$id),
      Query.orderDesc(r'$createdAt'),
    ],
  );
  return result.rows.map(_toNote).toList();
}

// Création : on stocke userId + permissions réservées au propriétaire
Future<Note> addNote(NoteDraft draft) async {
  final user = await account.get();
  final row = await tablesDB.createRow(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    rowId: ID.unique(),
    data: {
      'title': draft.title,
      'content': draft.content,
      'userId': user.$id,
    },
    permissions: [
      Permission.read(Role.user(user.$id)),
      Permission.update(Role.user(user.$id)),
      Permission.delete(Role.user(user.$id)),
    ],
  );
  return _toNote(row);
}

Future<Note> updateNote(String id, NoteDraft draft) async {
  final row = await tablesDB.updateRow(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    rowId: id,
    data: {'title': draft.title, 'content': draft.content},
  );
  return _toNote(row);
}

Future<void> deleteNote(String id) async {
  await tablesDB.deleteRow(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    rowId: id,
  );
}