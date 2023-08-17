import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _price = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> createProduct(String name, String category, int quantity, String image, double price) async {
    final Map<String, dynamic> data = {
      'name': name,
      'quantity': quantity,
      'category': category,
      'image': image,
      'price': price
    };
    final response = await http.post(
      Uri.parse('https://localhost:7291/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Falha na requisição. Status code: ${response.statusCode}');
    }
  }

  Future<String> imageUrlToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      List<int> byteList = response.bodyBytes;
      String base64Image = base64Encode(byteList);
      return base64Image;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Adicionar Produto'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home_outlined),
              tooltip: 'HomePage',
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              tooltip: 'Adicionar um produto',
              onPressed: () {
                Navigator.pushNamed(context, '/form');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Nome:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _name,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          else {
                            return ('O nome do produto é obrigatório');
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Produto',
                          hintText: 'Nome do Produto',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Imagem:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _image,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: 'Imagem do produto',
                          hintText: 'Imagem do produto',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Quantidade:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _quantity,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9 .]"))
                        ],
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            try {
                              double.parse(value);
                              return null;
                            } on Exception catch (_) {
                              return ('A quantidade é obrigatória');
                            }
                          } else {
                            return 'A quantidade é obrigatória';
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          labelText: 'Quantidade',
                          hintText: 'Quantidade',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Categoria:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _category,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }
                          else {
                            return 'A categoria é obrigatória';
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Categoria do produto',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Preço:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: _price,
                        keyboardType: TextInputType.number,

                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9 .]"))
                        ],
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            try {
                              double.parse(value);
                              return null;
                            } on Exception catch (_) {
                              return ('O preço é obrigatório');
                            }
                          } else {
                            return 'O preço é obrigatório';
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Preço do Produto',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Salvando o produto'),)
                      );
                      createProduct(
                          _name.text,
                          _category.text,
                          int.parse(_quantity.text),
                          imageUrlToBase64(_image.text).toString(),
                          double.parse(_price.text)
                      );
                      Navigator.popAndPushNamed(context,'/');
                    }
                  },
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
