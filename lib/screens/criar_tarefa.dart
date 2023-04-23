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
  List<DataStatus> _status = [DataStatus(statusId: 0, statusDescription: 'Aberta')];
  DataStatus _selectedStatus = DataStatus(statusId: 0, statusDescription: 'Aberta');
  List<DropdownMenuItem<DataStatus>> statusItems = [];
  String dropdownValue = 'Aberta';

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
                  child: DropdownButton<DataStatus>(
                    //isDense: true,
                    hint: Text('Choose'),
                    value: _selectedStatus,
                    icon: Icon(Icons.check_circle_outline),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.blue[300],
                    ),
                    onChanged: (DataStatus? value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                    items: _status.map<DropdownMenuItem<DataStatus>>((DataStatus value) {
                      return DropdownMenuItem<DataStatus>(
                        value: value,
                        child: Text(value.statusDescription),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: DropdownButton(
                      underline: Container(),
                      value: "New York",
                      items: [
                        //add items in the dropdown
                        DropdownMenuItem(child: Text("New York"), value: "New York"),

                        DropdownMenuItem(
                          child: Text("Tokyo"),
                          value: "Tokyo",
                        ),

                        DropdownMenuItem(
                          child: Text("Moscow"),
                          value: "Moscow",
                        )
                      ],
                      onChanged: (value) {
                        //get value when changed
                        print("You selected $value");
                      },
                    )),
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
                      underline: Container(),
                      value: "New York",
                      items: [
                        //add items in the dropdown
                        DropdownMenuItem(child: Text("New York"), value: "New York"),
                        DropdownMenuItem(child: Text("Tokyo"), value: "Tokyo"),
                        DropdownMenuItem(child: Text("Moscow"), value: "Moscow")
                      ],
                      onChanged: (value) {
                        //get value when changed
                        print("You selected $value");
                      },
                    )),
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }
}
