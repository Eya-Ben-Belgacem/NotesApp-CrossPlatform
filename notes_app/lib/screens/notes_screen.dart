import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/notes_service.dart' as service;
import '../widgets/note_input_dialog.dart';
import '../widgets/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> _notes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _showError(String title, Object e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title : $e')),
    );
  }

  // Lecture : récupère les notes depuis Appwrite
  Future<void> _load() async {
    try {
      final notes = await service.listNotes();
      if (!mounted) return;
      setState(() => _notes = notes);
    } catch (e) {
      _showError('Chargement impossible', e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _add() async {
    final draft = await showNoteInputDialog(context);
    if (draft == null) return;
    try {
      final created = await service.addNote(draft);
      if (!mounted) return;
      setState(() => _notes.insert(0, created));
    } catch (e) {
      _showError('Ajout impossible', e);
    }
  }

  Future<void> _edit(Note note) async {
    final draft = await showNoteInputDialog(context, initial: note);
    if (draft == null) return;
    try {
      final updated = await service.updateNote(note.id, draft);
      if (!mounted) return;
      setState(() {
        final index = _notes.indexWhere((n) => n.id == note.id);
        if (index != -1) _notes[index] = updated;
      });
    } catch (e) {
      _showError('Modification impossible', e);
    }
  }

  Future<void> _delete(String id) async {
    try {
      await service.deleteNote(id);
      if (!mounted) return;
      setState(() => _notes.removeWhere((n) => n.id == id));
    } catch (e) {
      _showError('Suppression impossible', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _notes.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('No notes yet.')),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        final note = _notes[index];
                        return NoteItem(
                          key: ValueKey(note.id),
                          note: note,
                          onEdit: () => _edit(note),
                          onDelete: () => _delete(note.id),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}