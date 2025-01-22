import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/localization/demo_localization.dart';
import 'package:shop/providers/cart_provider.dart';

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
  bool _addedToCart=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalization.of(context)?.translated_value('details')??"Details"),
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
                              _addedToCart=false;
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
                    icon: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child:_addedToCart ?Icon(Icons.check,color:Colors.white,key:ValueKey('tick')):Icon(Icons.shopping_cart,color:Colors.black,key:ValueKey('cart')),
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
                        setState(() {
                          _addedToCart=true;
                        });
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:
                            Text(DemoLocalization.of(context)?.translated_value('size_select_message')??"Please Select Size"),
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _addedToCart?Colors.green:Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    label: Text(
                      _addedToCart? DemoLocalization.of(context)?.translated_value('added')??'Added'
                          :DemoLocalization.of(context)?.translated_value('add_to_cart')??'Add To Cart',
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
