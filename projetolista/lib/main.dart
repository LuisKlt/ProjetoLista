import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/pessoa.dart';
import 'cardwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Lista para Widget",
      home: ModalMenu(),
    );
  }
}

class ModalMenu extends StatefulWidget {
  const ModalMenu({super.key});

  @override
  State<ModalMenu> createState() => _ModalMenuState();
}

class _ModalMenuState extends State<ModalMenu> {
  List<Pessoa> lista = [
    Pessoa(nome: "Luis", idade: 21, sobrenome: "Lima", cpf: "000.000.000-00"),
    Pessoa(
        nome: "Eduardo", idade: 22, sobrenome: "Freitas", cpf: "111.111.111-11")
  ];

  void removerItem(int index) {
    setState(() {
      lista.removeAt(index);
    });
  }

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();

  void openModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Cadastro de usuários",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(label: Text("Nome")),
                  ),
                  TextField(
                    controller: sobrenomeController,
                    decoration: InputDecoration(label: Text("Sobrenome")),
                  ),
                  TextField(
                    controller: idadeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      label: Text("Idade"),
                    ),
                  ),
                  TextField(
                    controller: cpfController,
                    decoration: InputDecoration(
                      label: Text("CPF"),
                    ),
                  ),
                  Expanded(child: Column()),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.amber),
                          foregroundColor: WidgetStatePropertyAll(Colors.black),
                          minimumSize:
                              WidgetStatePropertyAll(Size.fromHeight(60))),
                      onPressed: () {
                        setState(() {
                          lista.add(Pessoa(
                              nome: nomeController.text,
                              idade: int.parse(idadeController.text),
                              sobrenome: sobrenomeController.text,
                              cpf: cpfController.text));
                        });
                        Navigator.pop(context);
                        nomeController.clear();
                        sobrenomeController.clear();
                        idadeController.clear();
                        cpfController.clear();
                      },
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 22),
                      )),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de cadastros"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return Cardwidget(
            nome: lista[index].nome,
            sobrenome: lista[index].sobrenome,
            onRemove: () => removerItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            openModal();
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add)),
    );
  }
}
