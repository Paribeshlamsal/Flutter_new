import 'package:flutter/material.dart';
import 'model/todo.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final List<Todo> todos = [
    Todo(
      id: '1',
      title: 'Buy Milk',
      description: "Buy 2 liters of milk",
      isCompleted: true,
    ),
    Todo(
      id: '2',
      title: 'Study Flutter',
      description: "Study Flutter for 2 hours",
    ),
    Todo(
      id: '3',
      title: 'Exercise',
      description: "Do 30 minutes of exercise",
      isCompleted: true,
    ),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTodo() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the box
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text;
                  final description = _descriptionController.text;

                  if (title.isNotEmpty && description.isNotEmpty) {
                    setState(() {
                      todos.add(
                        Todo(
                          id: DateTime.now().toString(),
                          title: title,
                          description: description,
                        ),
                      );
                    });

                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.of(context).pop(); // Close the box after adding
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            leading: Icon(
              todo.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: todo.isCompleted ? Colors.green : null,
            ),
            title: Text(todo.title),
            subtitle: Text(todo.description ?? ''),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
