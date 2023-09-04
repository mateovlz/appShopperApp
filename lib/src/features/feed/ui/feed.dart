import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopper_mv_app/src/common_widgets/custom_scaffold.dart';
import 'package:shopper_mv_app/src/features/feed/dataprovider/product_provider.dart';
import 'package:shopper_mv_app/src/features/feed/services/product_services.dart';

import '../../../common_widgets/custom_scaffold_drawer.dart';
import '../domain/product.dart';

class Feed extends ConsumerStatefulWidget {
  const Feed({super.key, required this.title});
  final String title, route = '/feed';

  @override
  ConsumerState<Feed> createState() => _FeedState();

}

class _FeedState extends ConsumerState<Feed> {
  @override
  Widget build(BuildContext context){
    ref.read(productNotifier.notifier).fetchProducts();
    final lstProducts = ref.watch(productNotifier);

    //print(lstProducts);
    return CustomScaffoldDrawer(
      title: 'Shopper',
      activeAddButton: true,
      body: ProductList(products: lstProducts)
    );
  }
}

class ProductList extends ConsumerWidget {
  const ProductList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AlertDialog alert(String id) => AlertDialog(
      title: const Text("Deleting Product"),
      content: const Text("Are you sure you want to delete this product?.",
        textAlign: TextAlign.justify,
      ),
      contentTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 13
      ),
      titleTextStyle: GoogleFonts.poppins(
          color: Color(0xFFfc5c7d),
          fontSize: 25
      ),
      actions: [
        TextButton(
          onPressed: () {
            deleteProduct(id);
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
      ],
    );

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            //color: Color(0xffF26716),
            /*border: Border.all(
              width: 1,
              color: Color(0xffc5c0c0)
            ),*/
            boxShadow: [
              BoxShadow(
                color: Color(0xffc5c0c0),
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(
                    0.0,
                    0.0
                )
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
          ),
          child: Column(
            children: <Widget> [
              Text(
                  products[index].name,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  )
              ),
              Row(
                children:<Widget> [
                  Expanded(
                      child: Text(
                        products[index].description,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff414141),
                            fontSize: 12,
                          )
                      )
                  )
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  Text(
                      'In Stock:',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                      )
                  ),
                  Text(
                      products[index].stock.toString(),
                      style: GoogleFonts.poppins(
                        color: const Color(0xff414141),
                        fontSize: 13,
                      )
                  )
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  const Icon(
                    Icons.monetization_on_rounded,
                    color: Color(0xFF12A400),
                    size: 21,
                  ),
                  Text(
                      '${products[index].price} usd',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff414141),
                        fontSize: 13.5,
                      )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      try{
                        Navigator.pushNamed(
                            context,
                            '/newProduct',
                            arguments: products[index]);
                        //deleteProduct('as$products[index].id');
                        print(products[index].id);
                      } on Exception catch (e) {
                        print("Delete ocurr during Product deletion");
                        print(e);
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFFF2BD1D),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      //deleteProduct(products[index].id);
                      try{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert(products[index].id);
                          },
                        );
                        //deleteProduct('as$products[index].id');
                        print(products[index].id);
                      } on Exception catch (e) {
                        print("Delete ocurr during Product deletion");
                        print(e);
                      }
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                  )
                ],
              ),

            ],
          ),
        );
      },
    );
  }
}