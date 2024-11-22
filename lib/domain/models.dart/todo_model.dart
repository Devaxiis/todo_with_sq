class TodoModel {
  String title;
  String description;
  String createdAt;
  int count;

  TodoModel({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.count
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        title: json['title'] as String,
        description: json["description"] as String,
        createdAt: json["createdAt"] as String,
        count:json["count"] as int,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        'createdAt': createdAt,
        "count":count
      };

  @override
  String toString() {
    return 'TodoModel{title: $title, description: $description,description: $description ,isComplate:$count';
  }
}
