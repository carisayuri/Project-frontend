import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_frontend/product.dart';
import 'package:project_frontend/views/product_box.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    productsList();
  }

  Future<void> productsList() async {
    final response = await http.get(Uri.parse('https://localhost:7291/products'));
    try{
      if (response.statusCode == 200) {
        final List<dynamic> productListData = jsonDecode(response.body);
        setState(() {
          productList = productListData.map((data) => Product.fromJson(data)).toList();
        });
      } else {
        print('Falha na requisição. Status code: ${response.statusCode}');
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
              size: 28,
            ),
            tooltip: 'HomePage',
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add_box_outlined,
              size: 28,
            ),
            tooltip: 'Adicionar um produto',
            onPressed: () {
              Navigator.pushNamed(context, '/form');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for( var product in productList)
                  ProductBox(
                    id: product.id,
                    name: product.name,
                    quantity: product.quantity,
                    category: product.category,
                    image: product.image,
                    price: product.price,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
