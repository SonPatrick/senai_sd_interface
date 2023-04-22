import 'package:flutter/material.dart';
import 'package:senai_sd/models/tasks_model.dart';

import 'package:provider/provider.dart';
import '../repo/dados_repo.dart';

class InserirObservacao extends StatefulWidget {
  final int idUser;
  final TaskData data;
  const InserirObservacao({Key? key, required this.data, required this.idUser}) : super(key: key);

  @override
  State<InserirObservacao> createState() => _InserirObservacaoState();
}

class _InserirObservacaoState extends State<InserirObservacao>
    with AutomaticKeepAliveClientMixin<InserirObservacao> {
  TextEditingController _observacaoCtrl = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.watch<DadosRepository>();
    var idUser = Provider.of<DadosRepository>(context).idUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.black,
        title: Text(
          'Nova Observação',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _observacaoCtrl,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              readOnly: (widget.data.taskUserId != widget.idUser),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Descreva a providência',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Background color
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return InserirObservacao(data: widget.data, idUser: widget.idUser);
                  },
                );
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
