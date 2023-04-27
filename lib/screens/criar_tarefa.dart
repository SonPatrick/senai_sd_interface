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

  String currentStatus = "";
  String currentPrioridade = "";
  String currentTipo = "";

  List<String> _status = ["Aberta", "Fechada", "Concluída"];
  List<String> _prioridade = ["Sem Prioridade", "Alta", "Média", "Baixa"];
  List<String> _tipos = ["Incidente", "Solicitação de Serviço", "Melhorias", "Projetos"];

  var statusMap;
  Api api = Api();

  void loadStatus() async {
    var status = await api.listarStatus();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    currentStatus = _status[0];
    currentPrioridade = _prioridade[0];
    currentTipo = _tipos[0];

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Container(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Prioridade: ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: DropdownButton(
                                underline: SizedBox.shrink(),
                                alignment: Alignment.topCenter,
                                borderRadius: BorderRadius.circular(8),
                                dropdownColor: Colors.white,
                                value: currentPrioridade,
                                items: _prioridade
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Container(
                                          width: 200,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? value) => setState(
                                  () {
                                    if (value != null) currentPrioridade = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Status: ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: DropdownButton(
                                underline: SizedBox.shrink(),
                                alignment: Alignment.topCenter,
                                borderRadius: BorderRadius.circular(8),
                                dropdownColor: Colors.white,
                                value: currentStatus,
                                items: _status
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Container(
                                          width: 200,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(e),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? value) => setState(
                                  () {
                                    if (value != null) currentStatus = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tipos: ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: DropdownButton(
                                underline: SizedBox.shrink(),
                                alignment: Alignment.topCenter,
                                borderRadius: BorderRadius.circular(8),
                                dropdownColor: Colors.white,
                                value: currentTipo,
                                items: _tipos
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(e)),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (String? value) => setState(
                                  () {
                                    if (value != null) currentTipo = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ]),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 70,
        padding: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(width: 30),
              FloatingActionButton.extended(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text("Salvar")),
            ]),
      ),
    );
  }
}
