class Note {
  String id;
  String title;
  String content;
  DateTime createdAt;
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'].toString(),
      title: json['title'].toString(),
      content: json['content'].toString(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content};
  }
}
