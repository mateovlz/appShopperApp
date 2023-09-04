
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/feed/ui/feed.dart';
import '../features/feed/ui/newProduct.dart';
import '../features/home/ui/home.dart';
import '../features/login/ui/login.dart';
import '../features/sign_up/ui/sign_up.dart';
import '../features/feed/domain/product.dart';

final customRouterProvider = Provider<CustomRouter>((ref) {
  return CustomRouter();
});

class CustomRouter {
  CustomRouter();

  bool _isAuthenticated = false;

  bool get isAuthenticated =>
      _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  Route onGenerateRoute(RouteSettings settings) {

    print('=====================================');
    print('==== ROUTER ====');
    print('Navigating to route: ${settings.name}');
    print('Arguments: ${settings.arguments}');
    print('Is authenticated: $_isAuthenticated');
    print('=====================================');

    return _isAuthenticated ? _authenticatedRoutes(settings) : _notAuthenticatedRoutes(settings);
  }

  Route _authenticatedRoutes(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case '/feed':
        return MaterialPageRoute(
          builder: (context) => const Feed(title: 'Feed'),
          settings: routeSettings,
        );
      case NewProduct.route:
        return MaterialPageRoute(
          builder: (context) => NewProduct(title: 'New Product', product: routeSettings.arguments == null ?  Product(id: "",name:"",description: "",stock:0,price: 0) : routeSettings.arguments as Product,),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Feed(title: 'Feed'),
          settings: routeSettings,
        );
    }
  }

  Route _notAuthenticatedRoutes(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const Home(title: 'Home'),
          settings: routeSettings,
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const Login(title: 'Login'),
          settings: routeSettings,
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (context) => const SignUp(title: 'Sign Up'),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Home(title: 'Home'),
          settings: routeSettings,
        );
    }
  }
}
