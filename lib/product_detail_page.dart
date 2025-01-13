import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_provider.dart';

class ProductDetailPage extends StatefulWidget{
  final Map<String,Object> product;
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selected_size=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Image.asset(widget.product['imageUrl'] as String),
          const Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245,247,249,1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Text(
                  '\$${widget.product['price'] as double}',
                  style:Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context,index){
                      final size=(widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              selected_size=size;
                            });
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            backgroundColor: selected_size==size?Theme.of(context).primaryColor:Colors.white,
                          ),
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: (){
                      if(selected_size!=0){
                        Provider.of<CartProvider>(context,listen:false).add_product(
                            {
                              'title':widget.product['title'],
                              'price':widget.product['price'],
                              'imageUrl':widget.product['imageUrl'],
                              'company':widget.product['company'],
                              'size':selected_size,
                            }
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added Successfully')));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select Size')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    label: Text(
                      'Add To Card',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
