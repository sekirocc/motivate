import 'db.dart';

class Service {
  late String _dbPath;

  Service(String dbPath) {
    _dbPath = dbPath;
  }

  Future<NotebookDB> fetchNotebookData() async {
    print(_dbPath);

    await Future.delayed(const Duration(seconds: 4));

    // read fs

    Map<String, Map<String, String>> data = {};

    data["vim"] = {
      "vim-note1": "vim-note1-content",
      "vim-note2": "vim-note2-content",
      "vim-note3": "vim-note3-content",
    };

    data["git"] = {
      "git-note1": "git-note1-content",
      "git-note2": "git-note2-content",
      "git-note3": "git-note3-content",
      "git-note4": "git-note4-content",
      "git-note5": "git-note5-content",
      "git-note6": "git-note6-content",
      "git-note7": "git-note7-content",
    };

    return NotebookDB(data);
  }
}
