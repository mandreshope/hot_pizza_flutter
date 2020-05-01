import 'package:flutter/material.dart';
import 'package:hot_pizza/src/bloc/cartBloc.dart';
import 'package:hot_pizza/src/utils/globalVariable.dart';
import 'package:hot_pizza/src/widgets/animator.dart';
import 'package:hot_pizza/src/widgets/cartItem.dart';
import 'package:hot_pizza/src/widgets/loader.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc bloc;

  List<dynamic> items = new List<dynamic>();

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<CartBloc>(context);
    bloc.getAllCartItem();
    bloc.initTotal();
    items = bloc.cart..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.4,
        title: Text('Votre panier', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Loader(
                object: bloc.cart,
                callback: list,
              ),
            ),
            Container(
              height: 80,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${price.format(bloc.total)}",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      shape: BoxShape.rectangle,
                      color: bodyColor,
                      boxShadow: getShadow(),
                    ),
                    child: FlatButton(
                      child: Text("Commander", style: TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {},
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return WidgetANimator(
          Dismissible(
            child: CartItem(
              item: items[index],
            ),
            key: Key(items[index].id.toString()),
            onDismissed: (direction) {
              bloc.remove(items[index].id);
            },
            background: Container(
              color: Colors.red[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.red,
                          Colors.red[100],
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.red[100],
                          Colors.red,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
             
          )
        );
      },
    );
  }
}