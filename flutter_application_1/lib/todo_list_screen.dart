import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _todoList = [];

  void _addTask() {
    setState(() {
      _todoList.add(_textEditingController.text);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(labelText: 'Add a task'),
                ),
              ),
              IconButton(onPressed: () => _addTask(), icon: const Icon(Icons.add))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Text(_todoList[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
