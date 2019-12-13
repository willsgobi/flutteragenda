import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'adicionarevento.dart';
import 'editarevento.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Agenda"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection("events").snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Container(
                              // chamando a classe CardPet passando o edit como false
                                child: CardEvento(
                                    snapshot.data.documents[index].data));
                          });
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdicionarEvento()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CardEvento extends StatefulWidget {
  final Map<dynamic, dynamic> data;

  CardEvento(this.data);

  @override
  _CardEventoState createState() => _CardEventoState(data);
}

class _CardEventoState extends State<CardEvento> {

  final Map<dynamic, dynamic> data;

  _CardEventoState(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTMVSm6RLNI6WI2QZypeLQOlMg2QbzuG38mrOIcGe9ehoY_dzbR",
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Evento: ',
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, )),
                            TextSpan(
                                text: data["nome"],
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Dia: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(data["data"], style: TextStyle(fontSize: 20))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Hora: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: data["hora"],
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditarEvento(
                                  data["idEvent"],
                                  data["nome"],
                                  data["data"],
                                  data["hora"],
                                  data["idEvent"]
                              )
                              )
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blueAccent,),
                            label: Text("Editar")
                        )
                      ],
                    ),
                  ],
                ),
              )
            ]
        ),
    );
  }
}

