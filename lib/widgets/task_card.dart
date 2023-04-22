import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  int task_id = 1;
  String task_title = 'Corrigir Bug na tela';
  String task_description = 'Descrição da tarefa';
  String task_type = 'Alta';
  String task_criacao = '2023/01/01';
  String taks_status = 'Aberta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Tarefa $task_id'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(children: [
                SizedBox(height: 10),
                Text('$task_title'),
                TextField(
                  enabled: true,
                  readOnly: true,
                ),
                SizedBox(height: 10),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
