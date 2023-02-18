import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'model.dart';

class MyPanels extends StatefulWidget {
  const MyPanels({
    super.key,
    required this.initDB,
  });

  final NotebookDBModel initDB;

  @override
  State<StatefulWidget> createState() => _MyPanelsState();
}

class _MyPanelsState extends State<MyPanels> {
  late NotebookDBModel dbModel;

  @override
  void initState() {
    super.initState();
    dbModel = widget.initDB;
  }

  quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    MultiProvider ret = MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => dbModel,
        ),
      ],
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: Consumer<NotebookDBModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                      itemCount: model.notebooks.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: model.selectedNotebook == index
                              ? Colors.cyan
                              : Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              model.selectNotebook(index);
                            },
                            title: Text(model.notebooks.get(index).name),
                            shape: const Border(
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: 200,
                child: Consumer<NotebookDBModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                      itemCount: model.notes.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: model.selectedNote == index
                              ? Colors.amber
                              : Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              model.selectNote(index);
                            },
                            title: Text(model.notes.get(index).title),
                            shape: const Border(
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    quill.QuillToolbar.basic(controller: _controller),
                    Expanded(
                      child: Container(
                        color: const Color.fromARGB(255, 184, 163, 163),
                        child: quill.QuillEditor.basic(
                          controller: _controller,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return ret;
  }
}
