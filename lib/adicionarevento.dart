import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdicionarEvento extends StatefulWidget {
  @override
  _AdicionarEventoState createState() => _AdicionarEventoState();
}

class _AdicionarEventoState extends State<AdicionarEvento> {

  final _nomecontroller = TextEditingController();
  final _datacontroller = TextEditingController();
  final _horacontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime getData;
  DateTime getHour;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar evento"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                controller: _nomecontroller,
                decoration: InputDecoration(hintText: "coloque o nome"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _datacontroller,
                decoration: InputDecoration(hintText: "coloque a data"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _horacontroller,
                decoration: InputDecoration(hintText: "coloque o horário"),
                validator: (text) {
                  if (text.isEmpty) return "campo inválido";
                },
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Salvar"),
                  onPressed: () {
                    saveEvent();
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

  Future saveEvent() async {
    String dateNow = DateTime.now().millisecondsSinceEpoch.toString();
    // inicia o envio para o firestore e salva no Firestore com o nome da imagem enviada
    await Firestore.instance.collection("events").document(dateNow).setData({
      "nome": _nomecontroller.text,
      "data": _datacontroller.text,
      "hora": _horacontroller.text,
      "idEvent": dateNow
    });
  }
}
