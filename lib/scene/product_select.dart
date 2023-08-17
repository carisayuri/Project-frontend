import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:project_frontend/scene/product_edit.dart';

class ProductSelect extends StatefulWidget {
  const ProductSelect({
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
  State<ProductSelect> createState() => _ProductSelectState();
}

class _ProductSelectState extends State<ProductSelect> {

  Future<void> productDelete(int id) async {
    final response = await http.delete(Uri.parse('https://localhost:7291/products/$id'));
    if (response.statusCode == 200) {
      print('Produto deletado');
    } else {
      print('Falha na requisição. Status code: ${response.statusCode}');
    }
  }

  Future<void> _showAlert(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar o produto'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja realmente deletar este produto?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                productDelete(widget.id);
                Navigator.of(context).popAndPushNamed('/');
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Produtos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home_outlined),
            tooltip: 'HomePage',
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            tooltip: 'Adicionar um produto',
            onPressed: () {
              Navigator.of(context).pushNamed('/form');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: (widget.image.isNotEmpty && widget.image.isNotEmpty && widget.image.contains('http'))
                  ? Image.network(
                    widget.image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  )
                  : Container(
                    width: 200,
                    height: 200,
                    color: Colors.black12,
                    child: const Icon(
                      Icons.no_photography_outlined,
                      size: 64,
                    ),
                  ),
            ),
            const SizedBox(height: 20,),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              'Quantidade disponível: ${widget.quantity.toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              'Categoria: ${widget.category.toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              'Preço: ${NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$').format(widget.price).toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductEdit(
                          id: widget.id,
                          name: widget.name,
                          image: widget.image,
                          quantity: widget.quantity,
                          category: widget.category,
                          price: widget.price,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),
                  child: const Text('Editar'),
                ),
                const SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    _showAlert(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),
                  child: const Text('Deletar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
