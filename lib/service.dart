import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'model.dart';

class Service {
  late String _dbPath;

  Service(String dbPath) {
    _dbPath = dbPath;
  }

  Future<NotebookDBModel> fetchNotebookData() async {
    print(_dbPath);

    // await Future.delayed(const Duration(seconds: 1));

    // read fs
    Map<String, Map<String, String>> data = {};

    String selectedQuiverPath = "/Users/bytedance/Downloads/quiver_out";
    // print("users select quiver dir: $selectedQuiverPath");
    var notebookFolders =
        await Directory(selectedQuiverPath).list(recursive: false).toList();

    for (var notebookFolder in notebookFolders) {
      if (!isValidDir(notebookFolder)) continue;
      // print("notebookFolder: $notebookFolder");

      var noteDirs = await Directory(notebookFolder.path).list().toList();
      Map<String, String> noteContents = {};
      for (var noteFolder in noteDirs) {
        if (!isValidDir(noteFolder)) continue;
        // print("noteFolder: $noteFolder");

        var indexPage = p.join(noteFolder.path, "index.html");
        String content = await File(indexPage).readAsString();
        noteContents[p.basename(noteFolder.path)] = content;
      }

      data[p.basename(notebookFolder.path)] = noteContents;
    }

    return NotebookDBModel(data);
  }

  bool isValidDir(FileSystemEntity folder) {
    return !p.basename(folder.path).startsWith(".") &&
        folder.statSync().type == FileSystemEntityType.directory;
  }
}
