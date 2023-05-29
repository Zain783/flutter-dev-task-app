import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_test_app/models/taskModel.dart';
import 'package:uuid/uuid.dart';

class TaskUploadScreen extends StatefulWidget {
  @override
  _TaskUploadScreenState createState() => _TaskUploadScreenState();
}

class _TaskUploadScreenState extends State<TaskUploadScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _selectedFiles = [];

  Future<void> _uploadTask() async {
    if (_selectedFiles.isEmpty) {
      // Show an error message or handle empty attachments
      return;
    }

    // Generate a unique ID for the task
    final taskId = const Uuid().v4();

    // Upload each selected file and get their download URLs
    List<String> attachmentUrls = [];
    for (final file in _selectedFiles) {
      final ref = _storage
          .ref()
          .child('task_attachments')
          .child(taskId)
          .child(file.path);
      final task = ref.putFile(file);
      final snapshot = await task;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      attachmentUrls.add(downloadUrl);
    }

    // Create the task object with the entered data and attachment URLs
    final task = TaskModels(
      id: taskId,
      title: _titleController.text,
      description: _descriptionController.text,
      attachmentUrls: attachmentUrls,
    );

    // Save the task to the database or perform any additional operations

    // Clear the form and selected files
    _titleController.clear();
    _descriptionController.clear();
    _selectedFiles.clear();

    // Show a success message or navigate to a different screen
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickFiles,
              child: const Text('Select Files'),
            ),
            const SizedBox(height: 16.0),
            const Text('Selected Files:'),
            const SizedBox(height: 8.0),
           
            ElevatedButton(
              onPressed: _uploadTask,
              child: const Text('Upload Task'),
            ),
          ],
        ),
      ),
    );
  }
}