import 'package:flutter/material.dart';
import 'package:hot_pizza/src/bloc/cartBloc.dart';
import 'package:hot_pizza/src/models/cartItem.dart';
import 'package:hot_pizza/src/utils/globalVariable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;

  CartItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CartBloc>(context);
    final price = new NumberFormat.currency(locale: "fr_FR",
      symbol: "Ar");
    final double containtbox  = MediaQuery.of(context).size.width;
    final double pizzaImgBox = containtbox*0.3;
    final double detailBox = containtbox*0.5;
    final double boutonBox = containtbox*0.2-30;

    return Container(
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            width: pizzaImgBox,
            height: 100,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bodyColor,
              boxShadow: getShadow(),
            ),
          ),
          Container(
            width: detailBox,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(item.title, style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    "${price.format(item.price)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text("${price.format((item.price * item.quantity))}"),
                  Row(
                    children: item.ingredient.map((f) {
                      return Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.rectangle,
                          color: bodyColor,
                          boxShadow: getShadow(),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(f.image),
                        )
                      );
                    }).toList()
                  )
                ],
              ),
            ),
          ),
          //bouton increment decrement x right
          Container(
            width: boutonBox,
            child: Container(
              margin: EdgeInsets.only(top: 25, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                shape: BoxShape.rectangle,
                color: bodyColor,
                boxShadow: getShadow(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: FlatButton(
                      child: Text("+"),
                      onPressed: () {
                        bloc.increase(item);
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(item.quantity.toString()),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: FlatButton(
                      child: Text("-"),
                      onPressed: () {
                        bloc.decrease(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}