import 'package:flutter/material.dart';

import '../models/usuario_model.dart';

class DetalhesUsuario extends StatelessWidget {
  final Usuario task;

  const DetalhesUsuario({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(task.nome),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [Text(task.email)],
            )));
  }
}
