import 'package:flutter/material.dart';
import 'package:shop/global_variables.dart';
import 'package:shop/localization/demo_localization.dart';
import 'package:shop/widgets/product_card.dart';
import 'package:shop/pages/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> localized_filters(BuildContext context){
    return[
      DemoLocalization.of(context)?.translated_value('all')??"All",
      DemoLocalization.of(context)?.translated_value('adidas')??"Adidas",
      DemoLocalization.of(context)?.translated_value('nike')??"Nike",
      DemoLocalization.of(context)?.translated_value('bata')??"Bata",
    ];
  }
  late String selected_filter;
  late List<Map<String,Object>> filtered_products;
  TextEditingController _search_controller=TextEditingController();
  String search_query="";

  @override
  void initState() {
    super.initState();
    selected_filter="All";
    filtered_products=products;

    _search_controller.addListener((){
      setState(() {
        search_query=_search_controller.text.toLowerCase();
        filter_products(selected_filter,search_query);
      });
    });
  }

  void filter_products(String company,String query){
    setState(() {
      List<Map<String,Object>> temp_products=products;
      if(company!="All"){
        temp_products=products.where((products){
          return products['company']==company;
        }).toList();
      }

      filtered_products=temp_products.where((products){
        final title=products['title'] as String;
        return title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> filters=localized_filters(context);

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  DemoLocalization.of(context)?.translated_value('shoes_collection')??"Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _search_controller,
                    decoration: InputDecoration(
                      hintText: DemoLocalization.of(context)?.translated_value('search'),
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
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
                        filter_products(filter,search_query);
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
                itemCount: filtered_products.length,
                itemBuilder: (context,index){
                  final product=filtered_products[index];
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
