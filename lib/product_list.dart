import 'package:flutter/material.dart';
import 'package:shop/global_variables.dart';
import 'package:shop/product_card.dart';
import 'package:shop/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ["All", "Adidas", "Nike", "Bata"];
  late String selected_filter;

  @override
  void initState() {
    super.initState();
    selected_filter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: 240,
                child: TextField(
                  decoration: const InputDecoration(hintText: "Search", prefixIcon: Icon(Icons.search), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected_filter = filter;
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: selected_filter == filter ? Theme.of(context).primaryColor : Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      label: Text(filter),
                      labelStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context,index){
                  final product=products[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return ProductDetailPage(product: product);
                        },
                      ));
                    },
                    child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        background_color:index.isEven?Colors.lightBlueAccent:Colors.white
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
