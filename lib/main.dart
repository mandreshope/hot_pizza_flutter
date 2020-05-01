import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hot_pizza/src/bloc/cartBloc.dart';
import 'package:hot_pizza/src/bloc/flareActorBloc.dart';
import 'package:hot_pizza/src/models/cartItem.dart';
import 'package:hot_pizza/src/models/ingredient.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'src/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // Register Adapter
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(IngredientModelAdapter());

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartBloc>(create: (_) => CartBloc(),),
        ChangeNotifierProvider<FlareActorBloc>(create: (_) => FlareActorBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hot Pizza',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(title: 'Hot Pizza'),
      ),
    );
    
  }
}