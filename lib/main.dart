import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopper_mv_app/src/features/auth/auth.dart';
import 'package:shopper_mv_app/src/features/auth/user.dart';
//import 'package:shopper_mv_app/src/features/auth/auth.dart';
import 'package:shopper_mv_app/src/features/home/ui/home.dart';
import 'package:shopper_mv_app/src/provider/app_provider_obs.dart';
import 'package:shopper_mv_app/src/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ProviderScope(
          observers: [AppProviderObserver()],
          child: const MyApp()
      ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp>  with WidgetsBindingObserver{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //ref.read(authProvider).createUserWithEmailAndPassword('jasd','masd@aasd.com','12asd423423');
    //ref.read(authProvider).signOutUser();

    //bool isAuthenticated = false;
    var isAuthenticatedPr =  ref.read(authProvider).user!;
    isAuthenticatedPr.forEach((User) {
      if(User != null){
        //isAuthenticated = true;
        ref.read(customRouterProvider).isAuthenticated = true;
      }
    });

    return MaterialApp(
      //onGenerateRoute: (settings) => ref.read(customRouterProvider).onGenerateRoute(settings) ,
      onGenerateRoute: ref.read(customRouterProvider).onGenerateRoute,
      title: 'Shopper App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: Home(title:'asd'),
      debugShowCheckedModeBanner: false,
    );
  }
}
