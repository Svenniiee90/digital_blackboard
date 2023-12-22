import 'dart:io';

import 'package:digital_blackboard/src/bloc/blackboard_bloc.dart';
import 'package:digital_blackboard/src/models/bbitem.dart';
import 'package:digital_blackboard/src/screens/addItemDialog.dart';
import 'package:digital_blackboard/src/screens/blackboardItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BlackBoardBloc? _bbBloc;
  @override
  void initState() {
    _bbBloc = BlackBoardBloc();
    _bbBloc!.add(BlackBoardInitEvent());
    super.initState();
  }
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
              child: RefreshIndicator(
                color: Colors.blueGrey,
                semanticsValue: 'Aktuallisieren!',

                onRefresh: () {
                  _bbBloc!.add(BlackBoardGetAllItemsEvent());
                  return Future(() => null);
                  },
                child: BlocConsumer<BlackBoardBloc,BlackBoardState>(
                  bloc: _bbBloc,
                  listener: (context, state) {
                    
                  },
                  builder: (context, state) {
                    if (state is BlackBoardLoadingState) {
                      return const Center(child: CircularProgressIndicator(
                        color: Colors.blueGrey,
                      ));
                    }
                    if (state is BlackBoardLoadedState) {
                      print('hallo state' + state.resultList.length.toString());
                      return ListView.builder(
                        itemCount: state.resultList.length,
                        itemBuilder: (context, index) {
                          BBItem item = state.resultList[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 26,right: 26,top: 26),
                            child: BlackboardItem(
                              cdate: item.cdate, 
                              title: item.title, 
                              enddate: DateTime.now(), 
                              author: item.autor, 
                              imgpost: item.imgpost, 
                              imgSrc: item.img,
                              msg: item.msg),
                          );
                        });
                    }
                    return Container();
                  },
                  )
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
                      showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AddItemDialogState();
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