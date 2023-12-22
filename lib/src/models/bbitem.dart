class BBItem {

  late int id;
  late String title;
  late String msg;
  late String autor;
  late bool imgpost;
  late String img;
  late DateTime cdate;
  
  BBItem({required this.id, required this.title, required this.msg, required this.autor, required this.imgpost, required this.img, required this.cdate});

  BBItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print("id");
    title = json['title'];
    print("title");
    msg = json['msg'];
    print("msg");
    autor = json['autor'];
    print("autor");
    imgpost = json['imagePost'] as bool;
    print("imgpost");
    img = "https://dbb.codedudes.de/dbbServer/files/image/"+ id.toString();
    print("img");
    cdate = DateTime.parse(json['cdate'].toString());
    print("cdate");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {
      "id": id,
      "title": title,
      "msg": msg,
      "autor": autor,
      "img": imgpost,
    };
    return result;
  }

}