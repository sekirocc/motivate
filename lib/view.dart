import 'package:flutter/material.dart';
import 'package:notebook/db.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class MyPanels extends StatefulWidget {
  const MyPanels({super.key, required this.db});
  final NotebookDB db;

  @override
  State<StatefulWidget> createState() => _MyPanelsState();
}

class _MyPanelsState extends State<MyPanels> {
  var panels = FractionallySizedBox(
    widthFactor: 1,
    heightFactor: 1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Container(
              color: const Color.fromARGB(255, 175, 119, 76),
              child: Consumer<NotebooksModel>(
                builder: (context, notebooksModel, child) {
                  return ListView(
                    children:
                        notebooksModel.items.map((e) => Text(e.name)).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Container(
              color: const Color.fromARGB(255, 145, 133, 20),
              child: Consumer<NotesModel>(
                builder: (context, notesModel, child) {
                  return ListView(
                    children:
                        notesModel.items.map((e) => Text(e.title)).toList(),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 184, 163, 163),
              child: ListView(
                children: const [Text("mainPanel")],
              ),
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    NotebooksModel notebooksModel = widget.db.notebooks();
    NotesModel notesModel = widget.db.notes();

    MultiProvider ret = MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => notebooksModel,
        ),
        ChangeNotifierProvider(
          create: (context) => notesModel,
        ),
      ],
      child: panels,
    );

    return ret;
  }
}
