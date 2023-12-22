import 'dart:io';
import 'package:digital_blackboard/src/bloc/blackboard_bloc.dart';
import 'package:digital_blackboard/src/models/createbbitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddItemDialogState extends StatefulWidget {
  const AddItemDialogState({super.key});

  @override
  State<AddItemDialogState> createState() => _AddItemDialogStateState();
}

class _AddItemDialogStateState extends State<AddItemDialogState> {
  BlackBoardBloc? _bbbloc;
  File? _img;
  DateTime? start;
  DateTime? end;
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _msgCtrl = TextEditingController();
  final TextEditingController _startCtrl = TextEditingController();
  final TextEditingController _endCtrl = TextEditingController();
  final TextEditingController _autorCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bbbloc = BlackBoardBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.grey,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        child: Form(
          key: _formKey,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 550),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    const Text(
                      'Neuer Eintrag',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text('Titel*'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _titleCtrl,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Message'),
                    TextField(
                      controller: _msgCtrl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Bild hinzufügen'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          var tempImg = await picker.pickImage(
                            imageQuality: 60,
                            source: ImageSource.gallery,
                          );
                          if (tempImg != null) {
                            setState(() {
                              _img = File(tempImg.path);
                            });
                          }
                        },
                        icon: const Icon(Icons.add_photo_alternate)),
                        IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          var tempImg = await picker.pickImage(
                            imageQuality: 60,
                            source: ImageSource.camera,
                          );
                          if (tempImg != null) {
                            setState(() {
                              _img = File(tempImg.path);
                            });
                          }
                        },
                        icon: const Icon(Icons.add_a_photo)),
                      ],),
                    
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: _img == null
                          ? const Text('No image selected.')
                          : Image.file(
                              _img!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Startdatum*'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _startCtrl,
                      keyboardType: TextInputType.none,
                      onTap: () async {
                        start = await showDatePicker(
                            helpText: 'wählen Sie ein Startdatum!',
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 60)));
                        _startCtrl.text =
                            DateFormat('dd.MM.yyyy').format(start!);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Enddatum*'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _endCtrl,
                      keyboardType: TextInputType.none,
                      onTap: () async {
                        end = await showDatePicker(
                            helpText: 'wählen Sie ein Enddatum!',
                            context: context,
                            initialDate: start!,
                            firstDate: start!,
                            lastDate:
                                DateTime.now().add(const Duration(days: 120)));
                        _endCtrl.text = DateFormat('dd.MM.yyyy').format(end!);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Autor*'),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _autorCtrl,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('* erforderlich'),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Abbrechen')),
                        TextButton(
                            onPressed: () {
                              String title = _titleCtrl.text;
                              String msg = _msgCtrl.text;
                              String autor = _autorCtrl.text;
                              if (_formKey.currentState!.validate()) {
                                print("test passed!");
                                if (_img != null) {
                                   _bbbloc!.add(BlackBoardAddItemEvent(
                                    item: CreateBBItem(autor: autor, msg: msg, title: title, start: start!, end: end!),
                                    imgPost: (_img != null),
                                    image: _img!
                                ));
                                }
                                if (_img == null) {
                                   _bbbloc!.add(BlackBoardAddItemEvent(
                                item: CreateBBItem(autor: autor, msg: msg, title: title, start: start!, end: end!),
                                imgPost: (_img != null),
                                ));
                                }
                                
                                Navigator.pop(context);
                              }


                            },
                            child: const Text('Absenden'))
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
