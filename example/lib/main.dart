import 'package:flutter/material.dart';
import 'package:l2ksdk/l2ksdk.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LK.credentials(
      clientId: 'l2ksdk', clientSecret: 'a955b471-6157-4ad5-8904-895fd94c2327');
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
  List<LKProjectDesc> mandates = [];
  Widget get ____space____ => const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Leads2Keys API test')),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ____space____,
                          if (account == null)
                            ElevatedButton(
                                onPressed: () async {
                                  account = await LK.signIn(context);
                                  setState(() {});
                                },
                                child: const Text('Se connecter')),
                          if (account != null) ...[
                            Text(
                                '${account!.user.firstname} ${account!.user.lastname}'),
                            ____space____,
                            ElevatedButton(
                                onPressed: () async {
                                  mandates.clear();
                                  for (final a in account!.agencies) {
                                    mandates.addAll(
                                        await account!.mandates(agency: a));
                                  }
                                  setState(() {});
                                },
                                child: const Text('Afficher les mandats')),
                            ElevatedButton(
                                onPressed: () async {
                                  final places = await account!.placesId(
                                      agency: account!.agencies.first);
                                  print(places);
                                },
                                child: const Text('Afficher les mandats')),
                            ____space____,
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
                              ____space____,
                              ...mandates.map((m) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${m.project.type} ${m.good.type}',
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        Text(m.place.address),
                                        Wrap(
                                            spacing: 5,
                                            runSpacing: 5,
                                            children: m.good.tags
                                                .map((t) => Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            Colors.cyanAccent),
                                                    child: Text(t)))
                                                .toList()),
                                        ____space____,
                                        SizedBox(
                                            height: 64,
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, i) =>
                                                    Container(
                                                        child: account!
                                                            .document(m.good
                                                                .pictures[i])),
                                                separatorBuilder: (_, __) =>
                                                    const SizedBox(width: 5),
                                                itemCount:
                                                    m.good.pictures.length)),
                                        ____space____
                                      ]))
                            ]
                          ]
                        ])))));
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
