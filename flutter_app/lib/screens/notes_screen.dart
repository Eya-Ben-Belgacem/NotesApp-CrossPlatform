import 'package:flutter/material.dart';
import '../components/note_item.dart';
import '../components/note_input_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Données de départ
  List<Map<String, dynamic>> notes = [
    {
      'id': '1',
      'content': 'Learn Flutter',
      'createdAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'content': 'Complete the tutorial',
      'createdAt': DateTime.now().toIso8601String(),
    },
  ];

  final TextEditingController noteController = TextEditingController();
  Map<String, dynamic>? editingNote;

  // Ajouter ou modifier une note
  void addNote() {
    if (noteController.text.trim().isEmpty) return;

    setState(() {
      if (editingNote != null) {
        final index = notes.indexWhere((n) => n['id'] == editingNote!['id']);
        if (index != -1) {
          notes[index] = {
            ...notes[index],
            'content': noteController.text,
            'updatedAt': DateTime.now().toIso8601String(),
          };
        }
        editingNote = null;
      } else {
        notes.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': noteController.text,
          'createdAt': DateTime.now().toIso8601String(),
        });
      }
    });

    noteController.clear();
    Navigator.pop(context); // ferme la boîte de dialogue
  }

  // Supprimer une note
  void deleteNote(String id) {
    setState(() {
      notes.removeWhere((note) => note['id'] == id);
    });
  }

  // Passer en mode modification
  void editNote(Map<String, dynamic> note) {
    editingNote = note;
    noteController.text = note['content'];
    showNoteDialog();
  }

  // Afficher la boîte de dialogue (widget réutilisable)
  void showNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => NoteInputDialog(
        controller: noteController,
        isEditing: editingNote != null,
        onSave: addNote,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // En-tête avec titre et bouton +
          Container(
            height: 100,
            color: Colors.blue,
            padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    editingNote = null;
                    noteController.clear();
                    showNoteDialog();
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Liste des notes ou message "vide"
          Expanded(
            child: notes.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteItem(
                        note: note,
                        onEdit: () => editNote(note),
                        onDelete: () => deleteNote(note['id']),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No notes yet. Create one!',
                      style: TextStyle(fontSize: 18, color: Color(0xFF7F8C8D)),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}