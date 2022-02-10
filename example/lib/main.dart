import 'package:flutter/material.dart';
import 'package:l2ksdk/l2ksdk.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  LK.credentials(
      clientId: 'flutter',
      clientSecret: 'b076542a-13dd-4d7d-aed6-b4a741f6de8f');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test API L2K'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            const Text("Test de l'API de Leads2Keys"),
            ElevatedButton(
                onPressed: () async {
                  final account = await LK.signIn(context);
                },
                child: const Text("Se connecter")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Récupérer les mandats"))
          ],
        )));
  }
}
