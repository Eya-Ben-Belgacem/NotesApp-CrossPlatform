import { useCallback, useEffect, useState } from 'react';
import {
  ActivityIndicator,
  Alert,
  FlatList,
  Pressable,
  StyleSheet,
  Text,
  View,
} from 'react-native';

import { NoteInputModal, type NoteDraft } from '../components/NoteInputModal';
import { NoteItem } from '../components/NoteItem';
import { addNote, deleteNote, listNotes, updateNote } from '../lib/notesService';
import type { Note } from '../types';

export default function NotesScreen() {
  const [notes, setNotes] = useState<Note[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  // null = fermé, 'new' = création, une Note = modification
  const [editing, setEditing] = useState<Note | 'new' | null>(null);

  const showError = (title: string, e: unknown) => {
    const message = e instanceof Error ? e.message : String(e);
    Alert.alert(title, message);
  };

  // Lecture : récupère les notes depuis Appwrite
  const load = useCallback(async () => {
    try {
      setNotes(await listNotes());
    } catch (e) {
      showError('Chargement impossible', e);
    }
  }, []);

  // Au premier affichage de l'écran
  useEffect(() => {
    load().finally(() => setLoading(false));
  }, [load]);

  // Tirer la liste vers le bas pour la recharger
  const onRefresh = async () => {
    setRefreshing(true);
    await load();
    setRefreshing(false);
  };

  // Création ou modification
  const save = async (draft: NoteDraft) => {
    try {
      if (editing === 'new') {
        const created = await addNote(draft.title, draft.content);
        setNotes((prev) => [created, ...prev]);
      } else if (editing) {
        const updated = await updateNote(editing.id, draft.title, draft.content);
        setNotes((prev) => prev.map((n) => (n.id === updated.id ? updated : n)));
      }
      setEditing(null); // on ferme la fenêtre seulement si l'enregistrement a réussi
    } catch (e) {
      showError('Enregistrement impossible', e);
    }
  };

  // Suppression
  const remove = async (id: string) => {
    try {
      await deleteNote(id);
      setNotes((prev) => prev.filter((n) => n.id !== id));
    } catch (e) {
      showError('Suppression impossible', e);
    }
  };

  return (
    <View style={styles.container}>
      {loading ? (
        <ActivityIndicator size="large" style={styles.loader} />
      ) : (
        <FlatList
          data={notes}
          keyExtractor={(note) => note.id}
          contentContainerStyle={styles.list}
          refreshing={refreshing}
          onRefresh={onRefresh}
          ListEmptyComponent={<Text style={styles.empty}>No notes yet.</Text>}
          renderItem={({ item }) => (
            <NoteItem note={item} onEdit={setEditing} onDelete={remove} />
          )}
        />
      )}

      <Pressable
        style={styles.fab}
        onPress={() => setEditing('new')}
        accessibilityRole="button"
        accessibilityLabel="Add note">
        <Text style={styles.fabText}>+</Text>
      </Pressable>

      <NoteInputModal
        visible={editing !== null}
        initial={editing && editing !== 'new' ? editing : undefined}
        onSave={save}
        onCancel={() => setEditing(null)}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#fff' },
  loader: { marginTop: 48 },
  list: { padding: 16, gap: 12 },
  empty: { textAlign: 'center', color: '#60646c' },
  fab: {
    position: 'absolute',
    right: 20,
    bottom: 28,
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: '#208AEF',
    alignItems: 'center',
    justifyContent: 'center',
  },
  fabText: { color: '#fff', fontSize: 28, lineHeight: 32 },
});