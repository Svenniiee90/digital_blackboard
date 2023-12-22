import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:digital_blackboard/src/models/bbitem.dart';
import 'package:digital_blackboard/src/models/createbbitem.dart';

class BlackboardRepository {

  static final BlackboardRepository _repo = BlackboardRepository._privateConstructor();

  BlackboardRepository._privateConstructor();

  factory BlackboardRepository() {
    return _repo;
  }

  Future<void> addItem({required CreateBBItem item, required bool imagepost, File? image}) async {
    BBItem? createdItem;
    print("send rewuest for item");
    print((image != null).toString());
    Map<String, dynamic> request = {
        "user": "sven", 
        "createItem": {
          "title": item.title, 
          "msg": item.msg,
          "autor": item.autor,
          "imagePost": imagepost, 
          "start": item.start.toIso8601String(),
          "end": item.end.toIso8601String()
        }
        };
        String requestJSON = jsonEncode(request);
        Uri url1 = Uri.parse(
            'https://dbb.codedudes.de/dbbServer/files/addItem');
        Uri url2 = Uri.parse(
            'https://dbb.codedudes.de/dbbServer/files/upload');
        try {
          final response = await http.post(url1,
              headers: {'Content-Type': 'application/json'}, body: requestJSON);
          if (response.statusCode == 200) {
            Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
            if (result['state'] == 'Success') {
              print("sate is success");
              createdItem = BBItem.fromJson(result['item']);
              
            }
            if (result['state'] == 'Failed') {
              List<String> errors = List.from(result['execption']);
              StringBuffer errorMSG = StringBuffer();
              errors.forEach(
                (element) {
                  errorMSG.write(result['state'] + ': ' + element + '\n');
                },
              );
            }
          }
        } catch (e) {
          rethrow;
        }
        print("createdItem");
        print((createdItem!=null).toString());
        print(imagepost.toString());
        if (createdItem != null && imagepost) {
          print("mit bild");
          Map<String, dynamic> request2 = {
          "fileName": createdItem.id.toString(),
          "selectedFile": image!.readAsBytesSync()
          };
          final bodyelement = jsonEncode(request2);
          try {
            var request = http.MultipartRequest('POST', url2);
            request.fields.addAll({"fileName":createdItem.id.toString()+".jpeg"});
            request.files.add(http.MultipartFile('selectedFile', image.readAsBytes().asStream(),
      image.lengthSync(),));
            final response = await request.send();

              if (response.statusCode == 200) {
                print("success bild");
              }
          } catch (e) {
            print(e.toString());
            rethrow;
          }
        }
        
  }
  Future<List<BBItem>> getAllItems() async {
    List<BBItem> resultList = List.empty(growable: true);
    Map<String, dynamic> request = {
      "user": "sven"
    };
    String requestJSON = jsonEncode(request);
    Uri url = Uri.parse('https://dbb.codedudes.de/dbbServer/files/getAllItems');
    try {
      final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: requestJSON);
        if (response.statusCode == 200) {
          Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
          if (result['state'] == 'Success') {
            if (result['resultList'] != null) {
              result['resultList'].forEach((v) {
                BBItem item = BBItem.fromJson(v);
                resultList.add(item);
                });
            }
            return resultList;
          }
          if (result['state'] == 'Error') {
            throw Exception(result['error']);
          }
        }
    } catch (e) {
      rethrow;
    }
    return List.empty();
  }
}