import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Stock/models/products.dart';
import 'package:Stock/models/product.dart';
import 'package:Stock/Widgets/item_list.dart';

class ProductsGrid extends StatefulWidget {
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var valueSearch = '';
  final _searchController = TextEditingController();

  List<Product> filteredList = [];

  void _submitData(List<Product> products, String val) {
    final enteredVal = _searchController.text;
    valueSearch = _searchController.text;
    setState(() {
      filteredList = products
          .where((element) =>
              (element.name.toLowerCase().contains(val.toLowerCase())))
          .toList();
    });
  }

  @override
  void didChangeDependencies() {
    final productsInit = Provider.of<Products>(context, listen: false);
    filteredList = productsInit.items;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void changeData(List<Product> products, String val) {
    final enteredVal = _searchController.text;
    valueSearch = _searchController.text;
    setState(() {
      filteredList = products
          .where((element) =>
              (element.name.toLowerCase().contains(val.toLowerCase())))
          .toList();
    });
  }

  Future<void> refresh() async {
    final productsInit = await Provider.of<Products>(context, listen: false);
    filteredList = productsInit.items;
    return;
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 30,
          child: TextField(
            decoration: InputDecoration(labelText: 'Search'),
            controller: _searchController,
            onSubmitted: (val) => _submitData(products, val),
            onChanged: (val) => changeData(products, val),
            // onChanged: (val) {
            //   titleInput = val;
            // },
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: filteredList.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // builder: (c) => products[i],
              value: filteredList[i],
              child: ItemList(
                filteredList[i].id,
                filteredList[i].name,
                //   filteredList[i].imageUrl,
                filteredList[i].amount,
                filteredList[i].price,
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
        ),
      ],
    );
  }
}
