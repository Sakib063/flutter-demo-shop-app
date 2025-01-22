import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/localization/demo_localization.dart';
import 'package:shop/providers/cart_provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context){
    final cart=context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
        ),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context,index){
          final cart_item=cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cart_item['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: (){
                showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title:Text(DemoLocalization.of(context)?.translated_value('delete_product')??"Delete Product"),
                      content:Text(DemoLocalization.of(context)?.translated_value('warning')??"Are you sure you want to delete?"),
                      actions:[
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text(
                              DemoLocalization.of(context)?.translated_value('no')??"No",
                              style:TextStyle(color:Colors.green),
                            ),
                        ),
                        TextButton(
                          onPressed: (){
                            context.read<CartProvider>().remove_product(cart_item);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            DemoLocalization.of(context)?.translated_value('yes')??"Yes",
                            style:TextStyle(color:Colors.red),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete,color: Colors.red),
            ),
            title: Text(
              cart_item['title'].toString(),
              style:Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size ${cart_item['size']}'),
          );
        },
      ),
    );
  }
}
