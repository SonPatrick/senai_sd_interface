import 'package:flutter/material.dart';
import 'package:senai_sd/api/api.dart';
import 'package:senai_sd/models/tasks_model.dart';
import 'package:senai_sd/screens/criar_tarefa.dart';
import 'package:senai_sd/widgets/list_card.dart';
import 'package:circular_clip_route/circular_clip_route.dart';
import '../repo/dados_repo.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<int> _items = [1, 2, 3, 4];
  GlobalKey _fabKey = GlobalKey();
  List<TaskData> _tarefas = [];
  int? _selectedItem = 1;
  int _page = 0;

  void setPage(int page) => setState(() => _page = page);

  Api api = Api();
  void _carregarTarefas() async {
    Tarefas result = await api.listarTarefas(page: _page);

    if (result.status == 1 && result.data.length > 0) {
      setState(() {
        _tarefas = result.data;
      });
      print(_tarefas.first);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${result.message}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  void initState() {
    if (mounted) _carregarTarefas();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.watch<DadosRepository>();
    var idUser = Provider.of<DadosRepository>(context).idUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tarefas',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  elevation: 0.5,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CircularClipRoute<void>(
                        builder: (context) => const CriarTarefa(),
                        expandFrom: _fabKey.currentContext!,
                        curve: Curves.fastOutSlowIn,
                        reverseCurve: Curves.fastOutSlowIn,
                        opacity: ConstantTween(1),
                        transitionDuration: const Duration(milliseconds: 750),
                      ),
                    );
                  },
                  key: _fabKey,
                  label: Text('Criar tarefa'),
                  backgroundColor: Colors.orange,
                ),
              ),
            ),
          ],
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text('#', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Titulo', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Tipo', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Prioridade', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Data de abertura', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Responsável', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (BuildContext context, int index) {
          return CardList(
            data: _tarefas.elementAt(index),
            idUser: idUser,
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: _items.map((item) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ChoiceChip(
                        label: Text('${item}'),
                        selected: _selectedItem == item,
                        onSelected: (selected) {
                          setState(() {
                            _selectedItem = selected ? item : null;
                            if (selected) {
                              print('Selected: $item');
                            }
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
