import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_scaffold_drawer.dart';
import '../dataprovider/product_provider.dart';
import '../domain/product.dart';
import '../services/product_services.dart';


class NewProduct extends ConsumerStatefulWidget {
  const NewProduct({super.key, required this.title,  required this.product});

  final String title;

  final Product product;

  static const route = '/newProduct';

  @override
  ConsumerState<NewProduct> createState() => _NewProductState();

}

class _NewProductState extends ConsumerState<NewProduct> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool editing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product.id != ""){
      _nameController.text = widget.product.name;
      _descriptionController.text = widget.product.description;
      _stockController.text = widget.product.stock.toString();
      _priceController.text =widget.product.price.toString();
      editing = true;
    }
    //getSummary();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Widget inputControllers (
      TextEditingController controller,
      Icon icon,
      String label,
      TextInputType textInputType ) => Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
          )
        ]
    ),
    height: 60,
    child: TextField(
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(
          color: Colors.black87
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon,
          hintText: label,
          hintStyle: const TextStyle(
              color: Colors.black38
          )
      ),
    ),
  );

  @override
  Widget build(BuildContext context){

    Future createProduct({required String name, required String description, required int stock,required int price }) async {
      final docProduct = FirebaseFirestore.instance.collection('products').doc();
      final product = {
        'id': docProduct.id,
        'name': name,
        'description': description,
        'stock' : stock,
        'price' : price
      };

      await docProduct.set(product);

      ref.read(productNotifier.notifier).fetchProducts();

      Navigator.pop(context);
    }

    Future editProduct({required String name, required String description, required int stock,required int price }) async {
      final docProduct = FirebaseFirestore.instance.collection('products').doc(widget.product.id);
      final product = {
        'name': name,
        'description': description,
        'stock' : stock,
        'price' : price
      };

      await docProduct.update(product);

      ref.read(productNotifier.notifier).fetchProducts();

      Navigator.pop(context);
    }

    AlertDialog alert = AlertDialog(
      title: const Text("Notice"),
      content: const Text("Please fill out all the fields to create a new product.",
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
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Ok'),
        ),
      ],
    );
    return CustomScaffoldDrawer(
        title: 'Shopper',
        activeAddButton: false,
        body: SingleChildScrollView (
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Text(!editing ?
                'Create new product' : 'Editing Product',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF22222)
                ),
              ),
              SizedBox(height: 20,),
              inputControllers(_nameController, const Icon(Icons.label_rounded, color: Color(0xFFF29422)),'Name', TextInputType.text),
              inputControllers(_descriptionController, const Icon(Icons.description_rounded, color: Color(0xFFF29422)),'Description', TextInputType.text),
              inputControllers(_stockController, const Icon(Icons.inventory_2_rounded, color: Color(0xFFF29422)),'Stock', TextInputType.number),
              inputControllers(_priceController, const Icon(Icons.price_change_rounded, color: Color(0xFFF29422)),'Price', TextInputType.number),
              SizedBox(height: 20,),
              Container(
                width: 140,
                child: ElevatedButton(
                  onPressed: (){
                    if(_nameController.text.isEmpty || _descriptionController.text.isEmpty ||
                        _stockController.text.isEmpty || _priceController.text.isEmpty){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      if(!editing){
                        createProduct(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            stock: int.parse(_stockController.text),
                            price: int.parse(_priceController.text)
                        );
                      } else {
                        editProduct(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            stock: int.parse(_stockController.text),
                            price: int.parse(_priceController.text)
                        );
                      }
                    }
                  } ,
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFFF26716)
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
