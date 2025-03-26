import 'package:cart_interface/features/products/data/product_repositery.dart';
import 'package:cart_interface/features/products/logic/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/cart/logic/cart_bloc.dart';
import 'features/products/logic/product_event.dart';
import 'features/products/presentation/pages/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductRepository())..add(FetchProducts()),
        ),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cart Interface',
        theme: ThemeData(primaryColor: Color(0xFF075E54), useMaterial3: true),
        home: ProductListPage(),
      ),
    );
  }
}
