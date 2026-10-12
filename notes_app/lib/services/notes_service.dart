import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import '../appwrite_client.dart';
import '../models/note.dart';

// Transforme une ligne Appwrite en Note de l'application
Note _toNote(models.Row row) => Note(
  id: row.$id,
  title: (row.data['title'] ?? '') as String,
  content: (row.data['content'] ?? '') as String,
);

Future<List<Note>> listNotes() async {
  final result = await tablesDB.listRows(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    queries: [Query.orderDesc('\$createdAt')],
  );
  return result.rows.map(_toNote).toList();
}

Future<Note> addNote(NoteDraft draft) async {
  final row = await tablesDB.createRow(
    databaseId: appwriteDatabaseId,
    tableId: appwriteTableId,
    rowId: ID.unique(),
    data: {'title': draft.title, 'content': draft.content},
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
