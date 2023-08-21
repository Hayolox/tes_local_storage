// data/models/todo_model.dart

class ToDoModel {
  int? id; // Gunakan tipe data int? untuk mengizinkan nilai null
  String title;
  String description;

  ToDoModel({
    required this.title,
    required this.description,
    required this.id, // Tambahkan required pada id
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Hanya tambahkan id jika tidak null
      'title': title,
      'description': description,
    };
  }
}
