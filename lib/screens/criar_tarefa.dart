import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senai_sd/api/api.dart';
import 'package:senai_sd/models/prioridades_model.dart';
import 'package:senai_sd/models/tipos_model.dart';

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
  int _currentStatusId = 0;

  String currentPrioridade = "";
  int _currentPrioridadeId = 0;

  String currentTipo = "";
  int _currentTipoId = 0;

  List<DataStatus> _statusList = [];
  List<DataPrioridade> _prioridadeList = [];
  List<DataTipo> _tiposList = [];

  List<String> _status = [];
  List<String> _prioridade = [];
  List<String> _tipos = [];

  var statusMap;
  bool _isLoading = false;
  bool _loadingTarefa = false;
  Api api = Api();

  void setLoading(bool value) => setState(() => _isLoading = value);
  void setLoadingTarefa(bool value) => setState(() => _loadingTarefa = value);

  void loadStatus() async {
    setLoading(true);

    var status = await api.listarStatus();
    var tipos = await api.listarTipos();
    var prioridade = await api.listarPrioridade();
    if (status.data.length > 0 || prioridade.data.length > 0 || tipos.data.length > 0) {
      setLoading(false);
      setState(() {
        _status.clear();
        _tipos.clear();
        _prioridade.clear();

        _statusList = status.data;
        _tiposList = tipos.data;
        _prioridadeList = prioridade.data;

        status.data.forEach((element) => _status.add(element.statusDescription));
        tipos.data.forEach((element) => _tipos.add(element.typeDescription));
        prioridade.data.forEach((element) => _prioridade.add(element.priorityDescription));

        currentStatus = _status[0];
        currentPrioridade = _prioridade[0];
        currentTipo = _tipos[0];
      });
    }
  }

  void _selecionaStatus(String value) {
    var idStatus = _statusList.firstWhere((element) => element.statusDescription == value);
    setState(() => _currentStatusId = idStatus.statusId);
  }

  void _selecionaTipo(String value) {
    var idTipo = _tiposList.firstWhere((element) => element.typeDescription == value);
    setState(() => _currentTipoId = idTipo.typeId);
  }

  void _selecionaPrioridade(String value) {
    var idPrioridade =
        _prioridadeList.firstWhere((element) => element.priorityDescription == value);
    setState(() => _currentPrioridadeId = idPrioridade.priorityId);
  }

  void cadastrarTarefa(int idUSer) async {
    if (_titleCtrl.text.toString().isNotEmpty ||
        _titleCtrl.text.toString() != "" ||
        _descricaoCtrl.text.toString().isNotEmpty ||
        _descricaoCtrl.text.toString() != "") {
      setLoadingTarefa(true);
      var response = await api.cadastrarTarefa(
          _titleCtrl.text.toString(),
          _descricaoCtrl.text.toString(),
          _currentPrioridadeId,
          _currentStatusId,
          _currentTipoId,
          "${idUSer}");

      if (response.status == 1) {
        setLoadingTarefa(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.message}'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 5),
          ),
        );
        Navigator.pop(context, 1);
      } else {
        setLoadingTarefa(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.message}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      setLoadingTarefa(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos os campos são obrigatórios'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
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
    int idUser = Provider.of<DadosRepository>(context).idUser;

    print('Provider: ${idUser}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Inserir tarefa',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 0);
          },
        ),
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
              (!_isLoading)
                  ? Container(
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
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
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
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(e),
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? value) => setState(
                                        () {
                                          if (value != null) {
                                            currentPrioridade = value;
                                            _selecionaPrioridade(value);
                                          }
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
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
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
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(e),
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? value) => setState(
                                        () {
                                          if (value != null) {
                                            currentStatus = value;
                                            _selecionaStatus(value);
                                          }
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
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
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
                                                padding: const EdgeInsets.all(5.0),
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
                                          if (value != null) {
                                            currentTipo = value;
                                            _selecionaTipo(value);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    )
                  : Center(
                      child: SizedBox(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff8b002)))),
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
                      side: BorderSide(color: Colors.black, width: 2)),
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(width: 30),
              (!_loadingTarefa)
                  ? FloatingActionButton.extended(
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        cadastrarTarefa(idUser);
                      },
                      label: Text("Salvar"))
                  : Center(
                      child: SizedBox(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff8b002)))),
                    ),
            ]),
      ),
    );
  }
}
