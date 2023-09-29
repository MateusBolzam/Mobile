import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/usuario_model.dart';
import 'detalhes_usuario.dart';

import 'dart:math';

Random random = Random();

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() {
    return UsuariosState();
  }
}

class UsuariosState extends State<Usuarios> {
  TextEditingController nomeControl = TextEditingController();
  TextEditingController telefoneControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController dataControl = TextEditingController();
  TextEditingController UrlControl = TextEditingController();

  /// Lista de objetos da classe Usuario
  List<Usuario> ListaUsuario = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Usuarios Cadastrados")),
        body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              TextFormField(
                  controller: nomeControl,
                  decoration: const InputDecoration(
                      labelText: "Nome Completo", icon: Icon(Icons.task))),
              TextFormField(
                  controller: dataControl,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: "Data de Nascimento",
                      icon: Icon(Icons.calendar_month)),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1955),
                        lastDate: DateTime(2030));
                    if (pickedDate != null) {
                      String dataFormatada =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        dataControl.text = dataFormatada;
                      });
                    }
                  }),
              TextFormField(
                controller: emailControl,
                decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    labelText: "Digite seu Email"),
              ),
              TextFormField(
                controller: telefoneControl,
                decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    labelText: "Coloque seu telefone"),
              ),
              const SizedBox(height: 10),

              /// Botão responsável por cadastrar uma nova tarefa
              ElevatedButton(
                style: ButtonStyle(
                    // MediaQuery.of(context).size.width é a largura da tela do celular
                    // *0.75 indica que é 75% da largura
                    fixedSize: MaterialStatePropertyAll(
                        Size(MediaQuery.of(context).size.width * 0.75, 50)),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.greenAccent)),
                child: const Text("Cadastrar"),
                onPressed: () {
                  /// Instanciar um objeto da classe Tarefa
                  int urlRandom = random.nextInt(70) + 1;
                  String urlRandomS = urlRandom.toString();
                  String urls = "https://i.pravatar.cc/300?img=$urlRandomS";

                  Usuario task = Usuario(
                      id: ListaUsuario.length + 1,
                      nome: nomeControl.text,
                      data: dataControl.text,
                      telefone: telefoneControl.text,
                      email: emailControl.text,
                      url: urls);
                  setState(() {
                    ListaUsuario.add(task);
                  });
                },
              ),
              const Divider(),
              Expanded(
                /// listaTarefa - a lista em si
                /// index - o índice da lista
                /// listaTarefa[index] - item atual
                child: ListView.builder(
                  itemCount: ListaUsuario.length,
                  itemBuilder: (context, index) {
                    Usuario task = ListaUsuario[index];
                    return ListTile(
                      leading: ClipOval(
                        child: Image.network(ListaUsuario[index].url),
                      ),
                      // Operador condicional ternário
                      title: Text(task.nome,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue)),
                      subtitle: Text("${task.data}"),

                      onLongPress: () {
                        print("Ação on Long Press");
                        /*Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder:(context) => DetalhesTarefa(task: listaTarefa[index]),
                        )
                      );*/
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return DetalhesUsuario(task: ListaUsuario[index]);
                          },
                        );
                      },
                      onTap: () {
                        print("Ação Tap");
                      },
                    );
                  },
                ),
              )
            ])));
  }
}
