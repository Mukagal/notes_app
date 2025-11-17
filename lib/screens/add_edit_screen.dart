import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/storage_service.dart';

class AddEditScreen extends StatefulWidget {
  final Note? existingNote;
  const AddEditScreen({super.key, this.existingNote});
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      titleCtrl.text = widget.existingNote!.title;
      contentCtrl.text = widget.existingNote!.content;
    }
  }

  void _saveNote() async {
    final notes = await StorageService.getNotes();

    final newId = notes.isEmpty
        ? 0
        : notes.map((n) => int.parse(n.id)).reduce((a, b) => a > b ? a : b) + 1;

    final newNote = Note(
      id: newId.toString(),
      title: titleCtrl.text,
      content: contentCtrl.text,
      createdAt: DateTime.now(),
    );

    notes.add(newNote);
    await StorageService.saveNotes(notes);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingNote == null ? "Add Note" : "Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Write your note...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _saveNote();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
