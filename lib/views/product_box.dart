import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:project_frontend/scene/product_select.dart';

class ProductBox extends StatelessWidget {
  const ProductBox(
      {super.key,
      required this.id,
      required this.name,
      required this.quantity,
      required this.category,
      required this.image,
      required this.price});

  final int id;
  final String name;
  final int quantity;
  final String image;
  final String category;
  final double price;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductSelect(
              id: id,
              name: name,
              image: image,
              quantity: quantity,
              category: category,
              price: price,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: 200,
            alignment: Alignment.center,
            child: Column(
              children: [
                Center(
                  child: (image.isNotEmpty && image.isNotEmpty && image.contains('http'))
                      ? Image.network(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.scaleDown,
                      )
                      : Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        child: const Icon(
                          Icons.no_photography_outlined,
                          size: 32,
                        ),
                      )
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class CoverageCustomWithState extends StatefulWidget {
  const CoverageCustomWithState({super.key});

  @override
  State<StatefulWidget> createState() => CoverageCustomWithStateState();
}

class CoverageCustomWithStateState extends State<CoverageCustomWithState> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
