import 'package:flutter/material.dart';
import 'package:l2ksdk/l2ksdk.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LK.credentials(
      clientId: 'flutter',
      clientSecret: 'b076542a-13dd-4d7d-aed6-b4a741f6de8f');
  LK.signOut(); // 4debug
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leads2Keys API test'),
        ),
        body: Center(
            child: Column(
          children: [
            if (account == null)
              ElevatedButton(
                  onPressed: () async {
                    account = await LK.signIn(context);
                    setState(() {});
                  },
                  child: const Text('Se connecter')),
            if (account != null) ...[
              Text('${account!.user.firstname} ${account!.user.lastname}'),
              ElevatedButton(
                  onPressed: () {
                    //final mandates = account!.agency.getMandates(account!);
                  },
                  child: const Text('Afficher les mandats'))
            ]
          ],
        )));
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
