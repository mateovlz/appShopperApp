import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/router.dart';
import '../../auth/auth.dart';



class Home extends ConsumerStatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  ConsumerState<Home> createState() => _HomeState();
}


class _HomeState extends ConsumerState<Home> with WidgetsBindingObserver {
  final bool enabled = true;

  @override
  void initState() {
    super.initState();
    //Navigator.pushNamed(context, '/');
    /*Navigator.pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (BuildContext context) => const MyHomePage()),
      ModalRoute.withName('/'),
    );*/
  }

  test() {
    //ref.read(authProvider).signOutUser();

    bool isAuthenticated = false;
    var isAuthenticatedPr =  ref.read(authProvider).user!;
    isAuthenticatedPr.forEach((User) {
      if(User != null){
        isAuthenticated = true;
      }
    });
    bool auth = ref.read(customRouterProvider).isAuthenticated;
    print("Test Authentication $isAuthenticated");
    //print("Test Authentication 2 $auth");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      backgroundColor: const Color(0xFFfc5c7d),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFF23D5E),
          Color(0xFF6a82fb),
        ], stops: [
          0.35,
          0.8,
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Welcome to',
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Shopper',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: Icon(
                          Icons.shopping_cart_rounded,
                          size: 50.0,
                          color: Color(0xFFF29422),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                        //textStyle: Theme.of(context).textTheme.labelLarge,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        //textStyle: Theme.of(context).textTheme.labelLarge,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
