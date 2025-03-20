import 'package:flutter/material.dart';
import '../generic_selector.dart';
import 'selectable_chip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generic Selector Example',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ExampleScreen(),
    );
  }
}


/// Screen to show the example ///
class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {


  List<Product> allProducts = [
    Product(name: "Product 1", price: 10.0),
    Product(name: "Product 2", price: 20.0),
    Product(name: "Product 3", price: 30.0),
  ];
  List<Product> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text("Select a product"),
            const SizedBox(height: 12),
            GenericSelector<Product, SelectableChip>(
              wrapSpacing: 8,
              wrapRunSpacing: 6,
              layout: SelectorLayout.wrap,
              isMultiSelectMode: false,

              onItemSelected: (List<Product> selectedProduct) {
                /// Always return a list of selectedItems,
                /// in single select mode, the list has only 1 item.

                /// Do something with your selection
                selectedProducts.add(selectedProduct.first);
              },
              initialSelection: [
                allProducts.first,
              ],

              items: allProducts,

              selectableWidgetBuilder: (product, isSelected, onSelected) {
                return SelectableChip(
                  label: product.name,
                  onSelected:
                      onSelected, // Pass the onSelected callback which handles the selection logic to the widget
                  isSelected: isSelected,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Product Class ///
class Product {
  final String name;
  final double price;
  Product({required this.name, required this.price});
}
