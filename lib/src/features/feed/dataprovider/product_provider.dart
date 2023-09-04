
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopper_mv_app/src/features/feed/services/product_services.dart';

import '../domain/product.dart';


final productNotifier = StateNotifierProvider<ProductNotifier, List<Product> >((ref){
  return ProductNotifier();
});