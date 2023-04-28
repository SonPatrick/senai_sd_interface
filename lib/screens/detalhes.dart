import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senai_sd/api/api.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/screens/inserir_observacao.dart';
import '../utils/parse_data.dart';

import '../repo/dados_repo.dart';

class Detalhes extends StatefulWidget {
  final int idUser;
  final TaskData data;
  const Detalhes({Key? key, required this.data, required this.idUser}) : super(key: key);

  @override
  State<Detalhes> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<Detalhes> with AutomaticKeepAliveClientMixin<Detalhes> {
  TextEditingController _descricaoCtrl = TextEditingController();
  String _title = "";
  String _descricao = "";
  String _responsavel = "";
  String _dataCriacao = "";
  String _status = "";
  String _tipo = "";
  String _prioridade = "";

  Formatter formatter = Formatter();

  Api api = Api();

  void getStatus(String vStatus, String vPrioridade, String vTipo) async {
    var status = await api.listarStatus();
    var tipos = await api.listarTipos();
    var prioridade = await api.listarPrioridade();

    var idStatus = status.data.firstWhere((element) => element.statusDescription == vStatus);
    setState(() => {_status = idStatus.statusDescription});

    var idTipos = tipos.data.firstWhere((element) => element.typeDescription == vStatus);
    setState(() => _tipo = idTipos.typeDescription);

    var idPrioridade =
        prioridade.data.firstWhere((element) => element.priorityDescription == vStatus);
    setState(() => _prioridade = idPrioridade.priorityDescription);
  }

  void fillFields() {
    _title = widget.data.taskTitle;
    _descricaoCtrl.text = widget.data.taskDescription;
    _descricao = widget.data.taskDescription;
    _dataCriacao = formatter.parseDate(date: widget.data.createdAt);
    _responsavel = widget.data.userFullname;
  }

  void loadStatus() async {
    getStatus(widget.data.statusDescription, widget.data.priorityDescription,
        widget.data.typeDescription);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    if (mounted) loadStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.watch<DadosRepository>();
    var idUser = Provider.of<DadosRepository>(context).idUser;

    print('Provider: ${idUser}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Detalhes da tarefa ${widget.data.taskId}',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                _dataCriacao,
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Responsável: ",
                    style:
                        TextStyle(fontSize: 14, color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _responsavel,
                    style: TextStyle(
                        fontSize: 14, color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Visibility(
                visible: (widget.data.taskUserId == widget.idUser) ? false : true,
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // Background color
                    ),
                    onPressed: () {},
                    child: Text('Assumir tarefa'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descricaoCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Descrição da tarefa',
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Prioridade: ',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '${widget.data.priorityDescription}',
                      style:
                          TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tipo: ',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '${widget.data.typeDescription}',
                      style:
                          TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Status: ',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '${widget.data.statusDescription}',
                      style:
                          TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar")),
                  SizedBox(width: 10),
                  ElevatedButton(onPressed: () {}, child: Text("Salvar"))
                ],
              )
            ]),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return InserirObservacao(data: widget.data, idUser: widget.idUser);
            },
          );
        },
        child: SizedBox(
            height: 50,
            child: Container(
              color: Colors.indigo,
              child: Center(
                child: Text(
                  "Adicionar Providência",
                  style:
                      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            )),
      ),
    );
  }
}
