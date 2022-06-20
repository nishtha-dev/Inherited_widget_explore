import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApiProvider(
        api: Api(),
        child: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
          onTap: () {
            setState(() {
              title = DateTime.now().toIso8601String();
            });
          },
          child: Container(
            color: Colors.white,
          )),
    );
  }
}

class ApiProvider extends InheritedWidget {
  final String uuid;
  final Api api;
  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : uuid = const Uuid().v4(),
        super(child: child);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    if (uuid != oldWidget.uuid) {
      return true;
    }
    return false;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => DateTime.now().toIso8601String()).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}
