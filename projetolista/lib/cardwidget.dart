import 'package:flutter/material.dart';

class Cardwidget extends StatelessWidget {
  final String nome;
  final String sobrenome;
  final Function() onRemove;

  const Cardwidget(
      {required this.nome, required this.sobrenome, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "$nome",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$sobrenome",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
              onPressed: () {
                onRemove();
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
