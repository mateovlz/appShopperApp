import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_scaffold.dart';
import '../../auth/auth.dart';
import '../../auth/user.dart';



class Login extends ConsumerStatefulWidget{
  const Login({super.key, required this.title});

  final String title;

  @override
  ConsumerState<Login> createState() => _LoginState();

}

class _LoginState extends ConsumerState<Login> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getSummary();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    AlertDialog alert = AlertDialog(
      title: const Text("Notice"),
      content: const Text("Email or password are incorrect.",
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

    Future signIn(String email,String password, BuildContext context) async {
      // masd@aasd.com
      // 12asd423423
      try {
        Usera? user = await ref.read(authProvider).signInWithEmailAndPassword(email,password);

        if(user != null){
          Navigator.pushNamed(context, '/feed');
        }else {
          print('Not Sign In');
        }
      } on Exception catch (e) {
        print("Not Sign In controller error");
        print(e);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }

    return CustomScaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView (
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 120,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: Colors.black87
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                                Icons.email
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.black38
                            )
                        ),
                      ),
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
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
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top:14),
                            prefixIcon: Icon(
                                Icons.lock
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.black38
                            )
                        ),
                      ),
                    ),
                  ]
              ),
              Container(
                //padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      print('Hey');
                      signIn(_emailController.text, _passwordController.text, context);
                      //Navigator.pushNamed(context, '/feed');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
    );
  }
}