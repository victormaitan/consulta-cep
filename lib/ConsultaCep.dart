import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConsultaCep extends StatefulWidget {
  @override
  _ConsultaCepState createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  TextEditingController _cepController = TextEditingController();
  String rua;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String ddd;

  _recuperarCep() async {
    String url = "https://viacep.com.br/ws/${_cepController.text}/json/";

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      rua = retorno["logradouro"];
      complemento = retorno["complemento"];
      bairro = retorno["bairro"];
      cidade = retorno["localidade"];
      estado = retorno["uf"];
      ddd = retorno["ddd"];
    });

    print(retorno);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta CEP"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            padding: EdgeInsets.only(bottom: 32),
            child: TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                fillColor: Colors.deepPurple,
                labelText: "CEP",
                hintText: "CEP sem traço. Ex 987654321",
              ),
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text("Consultar"),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: () {
                _recuperarCep();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rua: ${rua}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Bairro: ${bairro}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Localidade: ${cidade}-${estado}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "DDD: ${ddd}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
