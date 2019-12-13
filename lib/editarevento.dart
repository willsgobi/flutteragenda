import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarEvento extends StatefulWidget {
  final String idEvento, nome, data, hora, eventInsert;

  const EditarEvento(this.idEvento, this.nome, this.data, this.hora, this.eventInsert);

  @override
  _EditarEventoState createState() =>
      _EditarEventoState(idEvento, nome, data, hora, eventInsert);
}

class _EditarEventoState extends State<EditarEvento> {
  final String idEvento, nome, data, hora, eventInsert;

  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  _EditarEventoState(this.idEvento, this.nome, this.data, this.hora, this.eventInsert);

  @override
  Widget build(BuildContext context) {
    setState(() {
      _nomeController.text = nome;
      _dataController.text = data;
      _horaController.text = hora;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Evendo"),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _keyForm,
          child: ListView(
            padding: EdgeInsets.all(15),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: (){
                        Firestore.instance.collection("events").document(idEvento).delete();
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.delete, color: Colors.red,),
                      label: Text("Excluir")
                  )
                ],
              ),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(hintText: "coloque o nome"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(hintText: "coloque a data"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _horaController,
                decoration: InputDecoration(hintText: "coloque o horário"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Atualizar"),
                  onPressed: () {
                    Firestore.instance.collection("events").document(idEvento).setData({
                      "nome": _nomeController.text,
                      "hora": _horaController.text,
                      "data": _dataController.text,
                      "idEvent": eventInsert
                    });
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
