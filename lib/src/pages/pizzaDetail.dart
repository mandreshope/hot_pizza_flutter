import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_pizza/src/bloc/cartBloc.dart';
import 'package:hot_pizza/src/bloc/flareActorBloc.dart';
import 'package:hot_pizza/src/models/cartItem.dart';
import 'package:hot_pizza/src/models/ingredient.dart';
import 'dart:math' as math;

import 'package:hot_pizza/src/models/pizza.dart';
import 'package:hot_pizza/src/pages/cart.dart';
import 'package:hot_pizza/src/utils/globalVariable.dart';
import 'package:provider/provider.dart';

class PizzaDetailPage extends StatefulWidget {
  final PizzaModel pizza;

  PizzaDetailPage({Key key, @required this.pizza}) : super(key: key);

  _PizzaDetailPageState createState() => _PizzaDetailPageState();
}

class _PizzaDetailPageState extends State<PizzaDetailPage> with TickerProviderStateMixin {
  final List<IngredientModel> ingredients = [];
  List<IngredientModel> _countIngredient = [];
  int _ingredientId;
  FlareActorBloc _flareActorbloc;
  CartBloc _cartBloc;

  AnimationController _animController, _animController2, _pizzaAnimController;
  Animation<double> animation, animation2, animation3, animation4, animation5, animation6, animBoxShow, animHiddePizza;

  bool isPizzaHidden = false;
  bool isAnimBox = false;
  bool isDraggable = true;

  @override
  void initState() {
    super.initState();
    ingredients.add(IngredientModel(1, "Chilli", 'assets/images/ing1.png', 1000));
    // ingredients.add(Ingredient(id: 2, title: "Proivron rouge", image: 'assets/images/ing2.png', price: 2000));
    ingredients.add(IngredientModel(3, "Oignon", 'assets/images/ing3.png', 500));
    // ingredients.add(Ingredient(id: 4, title: "Tomate", image: 'assets/images/ing4.png', price: 1000));
    // ingredients.add(Ingredient(id: 5, title: "Asperge", image: 'assets/images/ing5.png', price: 3000));
    ingredients.add(IngredientModel( 6, "Olive", 'assets/images/ing6.png', 5000));

     _animController = new AnimationController(
      duration: const Duration(seconds: 1), 
      vsync: this,
	  );

    _pizzaAnimController = new AnimationController(
      duration: const Duration(milliseconds: 100), 
      vsync: this,
	  );

    animHiddePizza = Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
          parent: _pizzaAnimController,
          curve:  Curves.linear,
      ),
    );

     _animController2 = new AnimationController(
      duration: const Duration(seconds: 1), 
      vsync: this,
	  );

    animBoxShow = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve:  Curves.fastOutSlowIn,
      ),
    );

    animation = Tween(begin: 0.1, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve:  Curves.easeIn,
      ),
    );

    animation2 = Tween(begin: 1.0, end: 5.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.4, 1.0, curve: Curves.easeIn), 
      ),
    );

    animation3 = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.5, 1.0, curve: Curves.linear), 
      ),
    );

    animation4 = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.8, 1.0, curve: Curves.linear), 
      ),
    );

  }

  @override
	void dispose(){
    _animController.dispose();
    _animController2.dispose();
    _pizzaAnimController.dispose();
    _flareActorbloc.isAnimated = false;
	  super.dispose();
	}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    _animController.forward();
    _flareActorbloc = Provider.of<FlareActorBloc>(context);
    _cartBloc = Provider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.4,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.pizza.title, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bodyColor,
              boxShadow: getShadow(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(context, 
                  PageRouteBuilder(
                    opaque: false,
                    transitionDuration: Duration(milliseconds: 400),
                    pageBuilder: (BuildContext context, _, __) => CartPage(),
                    transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child
                      );
                    }
                  )
                );
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: width/4.5,
            right: width/4.5,
            child: AnimatedBuilder(
                animation: _animController,
                builder: (BuildContext context, Widget child) => Transform.scale(
                  scale: animation2.value,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 5,),
                        BoxShadow(color: Colors.white, spreadRadius: 2),
                      ],
                    ),
                    width: 200,
                    height: 200,
                )
              )
            )
          ),
          //saucer
          if(!isPizzaHidden)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'saucer${widget.pizza.id}',
                  child: AnimatedBuilder(
                    animation: _animController, 
                    builder: (BuildContext context, Widget child) => Transform.rotate(
                      angle: math.pi*animation.value/8,
                      child: Opacity(opacity: 0.8,
                        child: Container(
                          child: Image.asset('assets/images/saucer.png'),
                          width: 220,
                        ),
                      )
                    )
                  )
                )
                
              ],
            )
          ),

          //pizza
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: -130,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: height/1.2,
                  child: Consumer<FlareActorBloc>(builder: (BuildContext context, blocFlareActor, child) => Container(
                    child: blocFlareActor.boxPizzaFlareActor(blocFlareActor.getIsAnimated)
                  )),
                  
                ),
              ),
              Positioned(
                top: 30,
                child: Container(
                  child: Hero(
                    tag: 'orderDetail${widget.pizza.id}',
                    child: dragtarget(context, widget.pizza.id),
                    
                  ),
                )
              ),
            ],
          ),

          // card price
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 250,),
                AnimatedBuilder(
                  animation: _animController,
                  builder: (BuildContext context, Widget child) => AnimatedOpacity(
                    opacity: animation3.value,
                    duration: Duration(milliseconds: 1000),
                    child: Container(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        shape: BoxShape.rectangle,
                        color: bodyColor,
                        boxShadow: getShadow(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${price.format(widget.pizza.price)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Divider(),
                          FlatButton(
                            child: Icon(Icons.add_shopping_cart, color: Theme.of(context).primaryColor, size: 28,),
                            onPressed: () {
                              _cartBloc.add(CartItemModel(
                                widget.pizza.id,
                                widget.pizza.title,
                                1,
                                widget.pizza.price.toDouble(),
                                widget.pizza.image,
                                _countIngredient,
                                DateTime.now()
                              ));
                              _flareActorbloc.setIsAnimated(true);
                              setState(() {
                                isAnimBox = true;
                                isPizzaHidden = true;
                                isDraggable = false;
                              });
                              _pizzaAnimController.forward().then((f) {
                              });
                            },
                          )
                        ],
                      )
                    ),
                  )

                )
              ],
            )
          ),
          //ingredient
          Center(
            child: AnimatedBuilder(
              animation: _animController, 
              builder: (BuildContext context, Widget child) => AnimatedOpacity(
                opacity: animation4.value, 
                duration: Duration(milliseconds: 500),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ingredients.map((f) {
                      return draggable(f);
                    }).toList()
                  )
                ),
              )
            )
            
          )
        ],
      )
    );
  }
  Widget draggable (IngredientModel data) {
    return Draggable(
      feedback: Container(
        child: Image.asset('assets/images/ing${data.id}.png'),
        width: 45,
        height: 45,
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.rectangle,
          color: bodyColor,
          boxShadow: getShadow(),
        ),
        width: 45,
        height: 45,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.rectangle,
          color: bodyColor,
          boxShadow: getShadow(),
        ),
        child: Image.asset('assets/images/ing${data.id}.png', fit: BoxFit.contain,),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(5),
        width: 45,
        height: 45,
      ),
      data: data,
      // onDragStarted: () {print('Drag started');},
      // onDragCompleted: () {print('Drag completed');},
      // onDragEnd: (c){
      //   print('Drag end');
      // },
    );

  }

  Widget dragtarget (BuildContext context, int id) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DragTarget(
      builder: (context, List<IngredientModel> candidateData, rejectedData) {
        return Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AnimatedBuilder(
                animation: isPizzaHidden ? _pizzaAnimController : _animController, 
                builder: (BuildContext context, Widget child) => isPizzaHidden ? 
                  Transform.scale(
                    scale: animHiddePizza.value,
                      child: Container(
                        margin: EdgeInsets.only(top:20),
                        child: Image.asset('assets/images/p$id.png'),
                        height: 200,
                        width: 200,
                    )
                  )
                : Transform.rotate(
                  angle: math.pi*animation.value/8,
                  child: Container(
                    child: Image.asset('assets/images/p$id.png'),
                    height: 200,
                    width: 200,
                  )
                ),
              ),
              /// ingredients animation topping
              if(isDraggable)
              Stack(
                children: <Widget>[
                  Container(
                    width: width/2,
                    height: height/3.5,
                    child: Container(
                      child: FlareActor('assets/chili_topping.flr', 
                        fit: BoxFit.contain,
                        animation: _ingredientId == 1 ? 'animate' : '',
                      ),
                    )
                  ),
                  Container(
                    width: width/2,
                    height: height/3.5,
                      child: Container(
                        child: FlareActor('assets/olive_topping.flr', 
                          callback: (v) {
                            if(v == 'animate'){
                              
                            }else {

                            }
                          },
                          fit: BoxFit.contain,
                          animation: _ingredientId == 6 ? 'animate' : '',
                        ),
                      )
                  ),
                  Container(
                    width: width/2,
                    height: height/3.5,
                      child: Container(
                        child: FlareActor('assets/oignon_topping.flr', 
                          callback: (v) {
                            if(v == 'animate'){
                              
                            }else {

                            }
                          },
                          fit: BoxFit.contain,
                          animation: _ingredientId == 3 ? 'animate' : '',
                        ),
                      )
                  )
                ], 
              )
            ],
          )
        );
      },
      onWillAccept: (data) {
        if(data != null) {
          return true;
        }else {
          return false;
        }
      },
      onAccept: (IngredientModel data) {
        // print('actepted');
        // print('${data.id}');
        setState(() {
          if (_countIngredient.length <= ingredients.length && isDraggable) {
            if (_countIngredient.contains(data.id) == false) {
              _countIngredient.add(data);
              _ingredientId = data.id; 
              widget.pizza.price = widget.pizza.price + data.price;
            }
          }
        });

      },
      onLeave: (data) {
        // print('rejected');
      },
    );
  }
}
