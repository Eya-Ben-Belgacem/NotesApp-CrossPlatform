import type { Note } from '../types';
import { DATABASE_ID, ID, Query, TABLE_ID, tablesDB } from './appwrite';

// Transforme une ligne Appwrite ($id, title, content...) en Note de l'application
function toNote(row: any): Note {
  return {
    id: row.$id,
    title: row.title,
    content: row.content ?? '',
  };
}

export async function listNotes(): Promise<Note[]> {
  const res = await tablesDB.listRows({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    queries: [Query.orderDesc('$createdAt')],
  });
  return res.rows.map(toNote);
}

export async function addNote(title: string, content: string): Promise<Note> {
  const row = await tablesDB.createRow({
    databaseId: DATABASE_ID,
    tableId: TABLE_ID,
    rowId: ID.unique(),
    data: { title, content },
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