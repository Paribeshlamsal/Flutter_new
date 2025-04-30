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
                  decoration: const InputDecoration(labelText: 'What to do ?'),
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
                  Navigator.of(context).pop(); // Close dialog
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
                    Navigator.of(context).pop(); // Close dialog
                  }
                },
                child: const Text('Add Todo'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body:
          todos.isEmpty
              ? const Center(
                child: Text(
                  'No any todos',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        todo.isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: todo.isCompleted ? Colors.green : null,
                      ),
                      onPressed: () {
                        setState(() {
                          todo.isCompleted = !todo.isCompleted;
                        });
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration:
                            todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    subtitle: Text(todo.description ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Delete"),
                              content: const Text(
                                "Are you sure you want to delete this item?",
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Delete"),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      todos.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Item deleted Successfully",
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Color.fromARGB(
                                          255,
                                          198,
                                          62,
                                          4,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
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
