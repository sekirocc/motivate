import 'model.dart';

class Service {
  late String _dbPath;

  Service(String dbPath) {
    _dbPath = dbPath;
  }

  Future<NotebookDBModel> fetchNotebookData() async {
    print(_dbPath);

    await Future.delayed(const Duration(seconds: 1));

    // read fs

    Map<String, Map<String, String>> data = {};

    data["vim"] = {
      "vim-note1": "vim-note1-content",
      "vim-note2": "vim-note2-content",
      "vim-note3": "vim-note3-content",
      "vim-note4": "vim-note4-content",
      "vim-note5": "vim-note5-content",
    };

    data["git"] = {
      "git-note1": "git-note1-content",
      "git-note2": "git-note2-content",
      "git-note3": "git-note3-content",
      "git-note4": "git-note4-content",
      "git-note5": "git-note5-content",
      "git-note6": "git-note6-content",
      "git-note7": "git-note7-content",
      "git-note8": "git-note7-content",
      "git-note9": "git-note7-content",
      "git-note10": "git-note7-content",
      "git-note11": "git-note7-content",
      "git-note12": "git-note7-content",
      "git-note13": "git-note7-content",
      "git-note14": "git-note7-content",
    };

    data["emacs"] = {
      "emacs-note1": "emacs-note1-content",
      "emacs-note2": "emacs-note2-content",
    };

    return NotebookDBModel(data);
  }
}
