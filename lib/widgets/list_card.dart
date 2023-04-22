import 'package:flutter/material.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/screens/detalhes.dart';
import 'package:senai_sd/utils/parse_data.dart';

class CardList extends StatefulWidget {
  final TaskData data;
  const CardList({Key? key, required this.data}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Formatter _formatter = Formatter();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Detalhes()));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.data.taskId}',
                      style: TextStyle(fontSize: 16, color: Colors.black38),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.data.taskTitle}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.data.typeDescription}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.data.priorityDescription}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      _formatter.parseDate(date: widget.data.createdAt),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      textAlign: TextAlign.center,
                      '${widget.data.userFullname}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
