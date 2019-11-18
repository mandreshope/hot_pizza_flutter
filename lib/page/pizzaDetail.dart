import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_pizza/model/ingredient.dart';
import 'package:hot_pizza/model/pizza.dart';
import 'dart:math' as math;
import 'package:hot_pizza/widgets/animIng.dart';

class PizzaDetailPage extends StatefulWidget {
  final Pizza pizza;

  PizzaDetailPage({Key key, @required this.pizza}) : super(key: key);

  _PizzaDetailPageState createState() => _PizzaDetailPageState();
}

class _PizzaDetailPageState extends State<PizzaDetailPage> with SingleTickerProviderStateMixin {
  final List<Ingredient> ingredients = [];
  List<int> _countIngredient = [];

  AnimationController _animController;
  Animation<double> animation, animation2, animation3, animation4, animation5, animation6;

  @override
  void initState() {
    super.initState();
    ingredients.add(Ingredient(id: 1, title: "Chilli", image: 'assets/images/ing1.png', price: 1000));
    ingredients.add(Ingredient(id: 2, title: "Proivron rouge", image: 'assets/images/ing2.png', price: 2000));
    ingredients.add(Ingredient(id: 3, title: "Oignon", image: 'assets/images/ing3.png', price: 500));
    ingredients.add(Ingredient(id: 4, title: "Tomate", image: 'assets/images/ing4.png', price: 1000));
    ingredients.add(Ingredient(id: 5, title: "Asperge", image: 'assets/images/ing5.png', price: 3000));
    ingredients.add(Ingredient(id: 6, title: "Olive", image: 'assets/images/ing6.png', price: 5000));

     _animController = new AnimationController(
      duration: const Duration(seconds: 1), 
      vsync: this,
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

    animation3 = Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn), 
      ),
    );

    animation4 = Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn), 
      ),
    );

  }

  @override
	void dispose(){
    _animController.dispose();
	  super.dispose();
	}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    _animController.forward();
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
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
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
                    width: 240,
                    height: 240,
                )
              )
            )
          ),
          //board
          Center(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'board${widget.pizza.id}',
                  child: AnimatedBuilder(
                    animation: _animController, 
                    builder: (BuildContext context, Widget child) => Transform.rotate(
                      angle: -math.pi*animation.value/2,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image.asset('assets/images/board.png'),
                        width: 240,
                      ),
                    )
                  )
                )
                
              ],
            )
          ),
          //pizza
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Hero(
                  tag: 'orderDetail${widget.pizza.id}',
                  child: dragtarget(context, widget.pizza.id),
                  
                ),
              ],
            )
          ),

          for (var i = 0; i < _countIngredient.length; i++) 
          AnimIng(anim: _countIngredient[i]),

          // _currentIngredient == '1' ? 
          // Center(
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(height: 100,),
          //       Container(
          //         height: 40,
          //         child: Image.asset('assets/images/ing1.png'),
          //       ),
          //     ],
          //   )
          // ) : Container(),
          // card price
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 250,),
                AnimatedBuilder(
                  animation: _animController,
                  builder: (BuildContext context, Widget child) => Transform(
                    transform: Matrix4.translationValues(0.0, animation3.value*height, 0.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('${widget.pizza.price} ar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Divider(),
                            RaisedButton(
                              color: Colors.redAccent,
                              child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 28,),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                        
                      ),
                    ),
                  )

                )
              ],
            )
          ),
          //ingredient
          Positioned(
            bottom: 10.0,
            child: AnimatedBuilder(
              animation: _animController, 
              builder: (BuildContext context, Widget child) => Transform(
                transform: Matrix4.translationValues(animation4.value*width, 0.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    children: ingredients.map((f) {
                      return draggable(f);
                    }).toList()
                  ),
                )
              )
            )
            
          )
        ],
      )
    );
  }
  Widget draggable (Ingredient data) {
    return Draggable(
      feedback: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/ing${data.id}.png'),
          )
        ),
        width: 45,
        height: 45,
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.redAccent, offset: Offset(0, 2), blurRadius: 5,),
            BoxShadow(color: Colors.white, spreadRadius: 2),
          ],
        ),
        width: 45,
        height: 45,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 5,),
            BoxShadow(color: Colors.white, spreadRadius: 2),
          ],
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/ing${data.id}.png'),
          )
        ),
        margin: EdgeInsets.all(7),
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
    return DragTarget(
      builder: (context, List<Ingredient> candidateData, rejectedData) {
        return AnimatedBuilder(
          animation: _animController, 
          builder: (BuildContext context, Widget child) => Transform.rotate(
            angle: -6/ 2*animation.value-math.pi,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/p$id.png')
                )
              ),
              height: 200,
              width: 200,
            )
          ),
        );
      },
      onWillAccept: (data) {
        if(data != null) {
          return true;
        }else {
          return false;
        }
      },
      onAccept: (Ingredient data) {
        print('actepted');
        print('${data.id}');
        setState(() {
          if (_countIngredient.length <= ingredients.length) {
            if (_countIngredient.contains(data.id) == false) {
              _countIngredient.add(data.id); 
              widget.pizza.price = widget.pizza.price + data.price;
            }
          }
        });

      },
      onLeave: (data) {
        print('rejected');
      },
    );
  }
}
