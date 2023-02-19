import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

import 'package:super_editor_markdown/super_editor_markdown.dart';

import 'model.dart';

class Editor extends StatelessWidget {
  final Note note;
  const Editor({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    var doc = deserializeMarkdownToDocument(html2md.convert(note.content));
    final docEditor = DocumentEditor(document: doc);

    return Expanded(
      child: Container(
        color: const Color.fromARGB(255, 184, 163, 163),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: SuperEditor(editor: docEditor),
          child: Text(html2md.convert(note.content)),
        ),
      ),
    );
  }
}
