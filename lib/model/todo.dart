class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final String description;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.description,
  });
}
