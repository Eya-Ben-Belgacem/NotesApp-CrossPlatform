import { tablesDB, DATABASE_ID, TABLE_ID, ID, Query, Permission, Role } from './appwrite';
import type { Note } from '../types';

// Transforme une ligne Appwrite ($id, title, content...) en Note de l'application
function toNote(row: any): Note {
  return {
    id: row.$id,
    title: row.title,
    content: row.content ?? '',
  };
}

export async function listNotes(userId: string): Promise<Note[]> {
  const res = await tablesDB.listRows({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    queries: [Query.equal('userId', userId), Query.orderDesc('$createdAt')],
  });
  return res.rows.map(toNote);
}

export async function addNote(userId: string, title: string, content: string): Promise<Note> {
  const row = await tablesDB.createRow({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    rowId: ID.unique(),
    data: { title, content, userId },
    // Seul le propriétaire peut lire, modifier ou supprimer cette note
    permissions: [
      Permission.read(Role.user(userId)),
      Permission.update(Role.user(userId)),
      Permission.delete(Role.user(userId)),
    ],
  });
  return toNote(row);
}

export async function updateNote(id: string, title: string, content: string): Promise<Note> {
  const row = await tablesDB.updateRow({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    rowId: id,
    data: { title, content },
  });
  return toNote(row);
}

export async function deleteNote(id: string): Promise<void> {
  await tablesDB.deleteRow({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    rowId: id,
  });
}