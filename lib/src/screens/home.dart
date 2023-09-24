import 'package:digital_blackboard/src/bloc/item_bloc.dart';
import 'package:digital_blackboard/src/screens/blackboardItem.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 34)),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  int listnr = index +1;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlackboardItem(cdate: DateTime.now(), title: 'Test ' + listnr.toString(),msg: 'hshshshshshs dco donlioe ijdoide3ln jdlsipid', enddate: DateTime.now(), author: 'Sven Wahl-Schwarz', imgpost: true, imgSrc: "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",)
                  );
                }
                ),
            ),
            Container(
              color: Colors.black,
              height: 80,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextButton(
                    onPressed: () {
                      DateTime? start;
                      DateTime? end;
                      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(18.0)),
                  child: Container(
                  constraints: const BoxConstraints(maxHeight: 550),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(children: [
                            const Text('Neuer Eintrag', style: TextStyle(fontSize: 24),),
                            const SizedBox(
                              height: 60,
                            ),
                            const Text('Titel*'),
                            TextField(),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Message'),
                            TextField(),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Bild hinzufügen'),
                            IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Startdatum'),
                            TextField(
                              keyboardType: TextInputType.none,
                              onTap: () async {
                                start = await showDatePicker(
                                  helpText: 'wählen Sie ein Startdatum!',
                                  context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60)));
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Enddatum'),
                            TextField(
                              keyboardType: TextInputType.none,
                              onTap: () async {
                                end = await showDatePicker(
                                  helpText: 'wählen Sie ein Enddatum!',
                                  context: context, initialDate: start!, firstDate: start!, lastDate: DateTime.now().add(const Duration(days: 120)));
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text('Autor'),
                            TextField(),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Abbrechen')),
                                TextButton(onPressed: () {}, child: Text('Absenden'))
                              ],
                            )
                      ],)
                    ),
                  ),
                        );
                    });
                    },
                    child: const Text('Post new one!', style: TextStyle(color: Colors.white, fontSize: 33),),
                    ),
                )
                ),
            )
          ],
        )
      ),
    );
  }
}