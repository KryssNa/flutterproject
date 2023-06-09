import 'package:flutter/material.dart';
import 'package:hunger_cravings/dashboard/widgets/featured_products.dart';
import '../../DetailsScreen/productdetail_screens.dart';
import '../../models/products.dart';
class SearchPage extends StatefulWidget {
SearchPage({Key? key}) : super(key: key);
@override
State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> _filteredProducts = [];
// Search query
  String _searchQuery = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Product product in _filteredProducts) {
      String productName = product.name;
      String productImage = product.image;
      double productPrice = product.price;
    }
    _filteredProducts = productList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                _searchQuery = value;
                _filterProducts(_searchQuery);
              },
              decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: 'Search.....',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _searchQuery.isEmpty
                  ? Container()
                  : _filteredProducts.length == 0
                  ? Text(
                'No result found Please try with different items',
                style: TextStyle(fontSize: 24),
              )
                  : ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) => Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                      ProductDetails(_filteredProducts[index])));
                    },
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("images/${_filteredProducts[index].image}"),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(_filteredProducts[index].name),
                    subtitle: Text(
                        'Price: ${_filteredProducts[index].price}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterProducts(String query) {
    List<Product> filteredSingleProductData = productList
        .where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredProducts = filteredSingleProductData;
    });
  }
}