import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class BlackboardItem extends StatelessWidget {
  DateTime cdate;
  DateTime enddate;
  String title;
  String msg;
  String author;
  String? imgSrc;
  bool imgpost;
  
  BlackboardItem({
    super.key,
    required this.cdate,
    required this.title,
    required this.enddate,
    required this.author,
    required this.imgpost,
    this.imgSrc,
    required this.msg
    });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Text(DateFormat('dd.MM.yyyy - kk:mm').format(cdate) ,style: const TextStyle(color: Colors.white, ),),
            Container(
              constraints: const BoxConstraints(minWidth: 420),
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0)), color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 26),),
                  const SizedBox(
                    height: 10,
                  ),
                  if(imgpost) ClipRRect(child: Image.network(imgSrc!),borderRadius: BorderRadius.all(Radius.circular(12))),
                  if(imgpost) const SizedBox(
                    height: 10,
                  ),
                  if(msg.isNotEmpty) Text(msg, style: TextStyle(color: Colors.white, fontSize: 14),),
                  const SizedBox(height: 25),
                ]),
              ),
            ),
            Text(author ,style: const TextStyle(color: Colors.white, ),)
      ]);
}
}