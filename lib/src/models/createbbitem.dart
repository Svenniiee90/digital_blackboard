import 'dart:io';

class CreateBBItem {

  late String title;
  late String msg;
  late String autor;
  late DateTime start;
  late DateTime end;
  late File? image;
  
  CreateBBItem({required this.autor, required this.title, required this.msg, this.image, required this.start, required this.end});
 
}