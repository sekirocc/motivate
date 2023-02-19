import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notebook/view.dart';
import 'package:window_manager/window_manager.dart';

import 'model.dart';
import 'service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  var windowsOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowsOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notebook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final Service svc = Service("");
  late Future<NotebookDBModel> futureNotebookData;
  @override
  void initState() {
    super.initState();
    futureNotebookData = svc.fetchNotebookData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          title: Text(
            widget.title,
            textScaleFactor: 0.8,
          ),
        ),
      ),
      body: FutureBuilder<NotebookDBModel>(
        future: futureNotebookData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyPanels(
              initDB: snapshot.data!,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
