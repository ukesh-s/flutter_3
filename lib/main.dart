import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Product {
  const Product(this.name, this.category, this.price, this.icon);
  final String name, category;
  final double price;
  final IconData icon;
}

const products = [
  Product('Wireless Headphones', 'Electronics', 79.99, Icons.headphones),
  Product('Smart Watch', 'Electronics', 129.00, Icons.watch),
  Product('Canvas Backpack', 'Accessories', 44.50, Icons.backpack),
  Product('Travel Mug', 'Home', 18.99, Icons.coffee),
  Product('Desk Lamp', 'Home', 32.00, Icons.light),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Product Explorer',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4169e1)), useMaterial3: true),
    home: const ProductPage(),
  );
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String query = '', category = 'All';
  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...products.map((p) => p.category).toSet()];
    final shown = products.where((p) => p.name.toLowerCase().contains(query.toLowerCase()) && (category == 'All' || p.category == category)).toList();
    return Scaffold(appBar: AppBar(title: const Text('Product Explorer'), centerTitle: true),
      body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 760), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search products', border: OutlineInputBorder()), onChanged: (v) => setState(() => query = v)),
        const SizedBox(height: 16), Wrap(spacing: 8, children: categories.map((c) => ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c))).toList()),
        const SizedBox(height: 16), Text('${shown.length} products', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8), Expanded(child: shown.isEmpty ? const Center(child: Text('No products match your search.')) : ListView.separated(itemCount: shown.length, separatorBuilder: (context, index) => const SizedBox(height: 8), itemBuilder: (context, i) { final p = shown[i]; return Card(child: ListTile(leading: CircleAvatar(child: Icon(p.icon)), title: Text(p.name), subtitle: Text(p.category), trailing: Text('\$${p.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)))); })),
      ])))));
  }
}
