import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopper_mv_app/src/routes/router.dart';

import '../features/auth/auth.dart';
import '../features/feed/dataprovider/product_provider.dart';
import '../features/home/ui/home.dart';

class CustomScaffoldDrawer extends ConsumerWidget {


  const CustomScaffoldDrawer({super.key, required this.title,required this.body, required this.activeAddButton});

  final bool activeAddButton;
  final Widget body;
  final String title;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF23D5E),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:5),
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Color(0xFFF29422),
                  size: 30,
                ),
              )
            ],
          ),
          actions: <Widget> [
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
                size: 30,
              ),
                onPressed: activeAddButton ? () {
                  print('asd');
                  Navigator.pushNamed(context, '/newProduct');
                } : null,
              disabledColor: Colors.red,
            ),
            SizedBox(
              width: 10,
            )
          ],
          leading: !activeAddButton ? null : Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
        drawer: !activeAddButton ? null : Drawer(
          child: Column(
            //padding: EdgeInsets.zero,
            children: <Widget>[
              Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget> [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF23D5E),
                        ),
                        child: Column(
                          children: <Widget> [
                             Row(
                              children: <Widget> [
                                Text('Shopping App',
                                  style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 5),
                                  child: Icon(
                                    Icons.shopping_cart_rounded,
                                    color: Color(0xFFF29422),
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                            /*Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  'Hi',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                  textAlign: TextAlign.start
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.shopping_bag,
                          color: Color(0xFFF22222)
                        ),
                        title: Text('Products',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black
                          ),
                        ),
                        selected: true,
                        onTap: (){
                          ref.read(productNotifier.notifier).fetchProducts();
                          Navigator.pop(context);
                          //Navigator.pushNamedAndRemoveUntil(context, '/feed', (route) => false);
                        },
                      ),
                    ],
                  )
              ),

              Container(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Column(
                      children: <Widget> [
                        //Spacer(), // <-- This will fill up any free-space
                        // Everything from here down is bottom aligned in the drawer
                        Divider(),
                        ListTile(
                          onTap: (){
                            ref.read(authProvider).signOutUser();
                            ref.read(customRouterProvider).isAuthenticated = false;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                Home(title: title)), (Route<dynamic> route) => false
                            );
                          },
                            title: Text('Sign Out',
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  color: Colors.black
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: false,
        body: body
    );
  }
}