import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senai_sd/api/api.dart';

import '../models/status.dart';
import '../repo/dados_repo.dart';

class CriarTarefa extends StatefulWidget {
  const CriarTarefa({super.key});

  @override
  State<CriarTarefa> createState() => _CriarTarefaState();
}

class _CriarTarefaState extends State<CriarTarefa> with AutomaticKeepAliveClientMixin<CriarTarefa> {
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descricaoCtrl = TextEditingController();
  List<DataStatus> _status = [];

  String selectedStatus = "Aberta";
  String selectedPrioridade = "Sem Prioridade";
  String selectedTipo = "Solicitação de Serviço";

  List<DropdownMenuItem<String>> get dropdownStatus {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Aberta"), value: "Aberta"),
      DropdownMenuItem(child: Text("Fechada"), value: "Fechada"),
      DropdownMenuItem(child: Text("Concluída"), value: "Concluída"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownPrioridade {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Sem Prioridade"), value: "Sem Prioridade"),
      DropdownMenuItem(child: Text("Alta"), value: "Alta"),
      DropdownMenuItem(child: Text("Média"), value: "Média"),
      DropdownMenuItem(child: Text("Baixa"), value: "Baixa"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownTipos {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Incidente"), value: "Incidente"),
      DropdownMenuItem(child: Text("Solicitação de Serviço"), value: "Solicitação de Serviço"),
      DropdownMenuItem(child: Text("Melhorias"), value: "Melhorias"),
      DropdownMenuItem(child: Text("Projetos"), value: "Projetos"),
    ];
    return menuItems;
  }

  int _selectedStatusId = 1;

  var statusMap;
  Api api = Api();

  void loadStatus() async {
    var status = await api.listarStatus();
    setState(() => _status = status.data);
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
          'Inserir tarefa',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(children: [
          TextField(
            controller: _titleCtrl,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Título da tarefa',
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descricaoCtrl,
            keyboardType: TextInputType.multiline,
            maxLines: null,
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
                  style:
                      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Container(
                  child: DropdownButton(
                    value: selectedPrioridade,
                    hint: Text("Prioridade"),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPrioridade = newValue!;
                      });
                    },
                    items: dropdownPrioridade,
                  ),
                ),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                SizedBox(width: 50),
                Text(
                  'Tipo: ',
                  style:
                      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButton(
                    value: selectedTipo,
                    hint: Text("Tipo"),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTipo = newValue!;
                      });
                    },
                    items: dropdownTipos,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  'Status: ',
                  style:
                      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButton(
                    value: selectedStatus,
                    hint: Text("Status"),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                    items: dropdownTipos,
                  ),
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
    );
  }
}
