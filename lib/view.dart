import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool panel1Visible = true;
  bool panel2Visible = true;
  bool panel3Visible = true;

  @override
  void initState() {
    super.initState();
    dbModel = widget.initDB;
    panel1Visible = true;
    panel2Visible = true;
    panel3Visible = true;
  }

  quill.QuillController _controller = quill.QuillController.basic();

  void changePanelsVisibility(int v) {
    bool p1Visible;
    bool p2Visible;
    bool p3Visible;
    if (v == 1) {
      p1Visible = false;
      p2Visible = false;
      p3Visible = true;
    } else if (v == 2) {
      p1Visible = false;
      p2Visible = true;
      p3Visible = true;
    } else {
      p1Visible = true;
      p2Visible = true;
      p3Visible = true;
    }
    setState(() {
      panel1Visible = p1Visible;
      panel2Visible = p2Visible;
      panel3Visible = p3Visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.digit1):
            TogglePanelViewIndent(1),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.digit2):
            TogglePanelViewIndent(2),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.digit3):
            TogglePanelViewIndent(3),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          TogglePanelViewIndent:
              TogglePannelViewAction(cb: changePanelsVisibility),
        },
        child: FocusScope(
          autofocus: true,
          child: MultiProvider(
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
                    !panel1Visible
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: 200,
                            child: Consumer<NotebookDBModel>(
                              builder: (context, model, child) {
                                return ListView.builder(
                                  physics: const ClampingScrollPhysics(),
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
                                        title: Text(
                                            model.notebooks.get(index).name),
                                        shape: const Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                    !panel2Visible
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: 200,
                            child: Consumer<NotebookDBModel>(
                              builder: (context, model, child) {
                                return ListView.builder(
                                  physics: const ClampingScrollPhysics(),
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
                                        title:
                                            Text(model.notes.get(index).title),
                                        shape: const Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: quill.QuillEditor.basic(
                                  controller: _controller,
                                  readOnly: false, // true for view only mode
                                ),
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
          ),
        ),
      ),
    );
  }
}

class TogglePanelViewIndent extends Intent {
  int i = -1;
  TogglePanelViewIndent(int param) {
    i = param;
  }
}

class TogglePannelViewAction extends Action<TogglePanelViewIndent> {
  void Function(int) cb;
  TogglePannelViewAction({required this.cb});

  @override
  Object? invoke(TogglePanelViewIndent intent) {
    int i = intent.i;
    int v = 3;
    if (i == 1) {
      v = 1;
    } else if (i == 2) {
      v = 2;
    } else {
      v = 3;
    }
    print("TogglePannelViewAction.invoke. $i");
    cb(v);
  }
}
