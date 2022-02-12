import 'package:flutter/material.dart';
import 'package:l2ksdk/l2ksdk.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LK.credentials(
      clientId: 'flutter',
      clientSecret: 'b076542a-13dd-4d7d-aed6-b4a741f6de8f');
  runApp(const MyApp());
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LKAccount? account;
  List<LKMandate> mandates = [];
  Widget get space => const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Leads2Keys API test')),
        body: Center(
            child: Column(
          children: [
            space,
            if (account == null)
              ElevatedButton(
                  onPressed: () async {
                    account = await LK.signIn(context);
                    setState(() {});
                  },
                  child: const Text('Se connecter')),
            if (account != null) ...[
              Text('${account!.user.firstname} ${account!.user.lastname}'),
              space,
              ElevatedButton(
                  onPressed: () async {
                    mandates.clear();
                    for (final a in account!.agencies) {
                      mandates.addAll(await account!.mandates(agency: a));
                    }
                  },
                  child: const Text('Afficher les mandats')),
              space,
              ElevatedButton(
                  onPressed: () {
                    LK.signOut();
                    setState(() {
                      account = null;
                      mandates.clear();
                    });
                  },
                  child: const Text('Se deconnecter')),
              if (mandates.isNotEmpty) ...[
                space,
                ...mandates.map((m) => Column(children: [
                      Text('${m.project.type} ${m.good.type}'),
                      Text(m.place.address),
                      space
                    ]))
              ]
            ]
          ],
        )));
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
