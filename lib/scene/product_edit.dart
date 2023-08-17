import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_frontend/scene/product_select.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({
    Key? key,
    required this.id,
    required this.name,
    required this.quantity,
    required this.image,
    required this.category,
    required this.price,
  }) : super(key: key);
  final int id;
  final String name;
  final int quantity;
  final String image;
  final String category;
  final double price;

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  late TextEditingController _name;
  late TextEditingController _image;
  late TextEditingController _quantity;
  late TextEditingController _category;
  late TextEditingController _price;

  Future<void> productUpdate(int id,String name, int quantity, String category, String image, double price) async {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category,
      'image': image,
      'price': price,
    };

    final response = await http.put(
      Uri.parse('https://localhost:7291/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('Falha na requisição. Status code: ${response.statusCode}');
    }
  }


  @override
  void initState() {
  super.initState();
  _name = TextEditingController(text: widget.name);
  _image = TextEditingController(text: widget.image);
  _quantity = TextEditingController(text: widget.quantity.toString());
  _category = TextEditingController(text: widget.category);
  _price = TextEditingController(text: widget.price.toString());
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Editar o Produto'),
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
                        productUpdate(
                          widget.id,
                          _name.text,
                          int.parse(_quantity.text),
                          _category.text,
                          _image.text,
                          double.parse(_price.text),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductSelect(
                              id: widget.id,
                              name: _name.text,
                              image: _image.text,
                              quantity: int.parse(_quantity.text),
                              category: _category.text,
                              price: double.parse(_price.text),
                            ),
                          ),
                        );
                        Navigator.of(context).pop;
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
            ),
        ),
      ),
    );
  }
}