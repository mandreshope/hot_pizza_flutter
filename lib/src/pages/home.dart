import 'package:flutter/material.dart';
import 'package:hot_pizza/src/bloc/cartBloc.dart';
import 'dart:math' as math;

import 'package:hot_pizza/src/models/pizza.dart';
import 'package:hot_pizza/src/pages/cart.dart';
import 'package:hot_pizza/src/pages/pizzaDetail.dart';
import 'package:hot_pizza/src/utils/globalVariable.dart';
import 'package:hot_pizza/src/widgets/pizzaSlide.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  int _slideIndex;
  List<PizzaModel> pizza = [
    PizzaModel(id: 1, title: "Pizza olive", image: "assets/images/p1.png", price: 10000, description: ''),
    PizzaModel(id: 2, title: "Pizza legume", image: "assets/images/p2.png", price: 6000, description: ''),
    PizzaModel(id: 3, title: "Pizza au fromage", image: "assets/images/p3.png", price: 20000, description: ''),
    PizzaModel(id: 4, title: "Pizza au tomate", image: "assets/images/p4.png", price: 7000, description: ''),
    PizzaModel(id: 5, title: "Pizza au poulet", image: "assets/images/p5.png", price: 10000, description: ''),
    PizzaModel(id: 6, title: "Pizza au champignon", image: "assets/images/p6.png", price: 15000, description: ''),
  ];
  int _currentPrice;
  String _currentTitle;
  PageController _pageController = PageController(viewportFraction: 0.5, initialPage: 5,);

  ValueNotifier<double> _notifier = ValueNotifier(0.0);
  AnimationController _animController;
  AnimationController _animController2;
  Animation<double> animation, animation3;

  void _goPizzaDetailPage(BuildContext context, v) {
    _animController2.reverse();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (BuildContext context, _, __) => PizzaDetailPage(pizza: v,),
        transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child
          );
        }
      )
    ).then((onValue) => _animController2.forward());
  }

  _goCartPage() {
    _animController2.reverse();
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => CartPage(),
      transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child
        );
      }
    )).then((onValue) => _animController2.forward());
  }

  @override
  void initState() {
    super.initState();
  
    _animController = new AnimationController(
      duration: const Duration(milliseconds: 1000), 
      vsync: this,
	  );

    _animController2 = new AnimationController(
      duration: const Duration(milliseconds: 1000), 
      vsync: this,
	  );

    animation3 = Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController2,
          curve: Interval(0.8, 1.0, curve: Curves.linear), 
      ),
    );

    _currentPrice = pizza[5].price;
    _currentTitle = pizza[5].title;


  }

  @override
	void dispose(){
    _animController.dispose();
     _animController2.dispose();
    _notifier?.dispose();
	  super.dispose();
	}

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    pizza = [
      PizzaModel(id: 1, title: "Pizza olive", image: "assets/images/p1.png", price: 10000, description: ''),
      PizzaModel(id: 2, title: "Pizza legume", image: "assets/images/p2.png", price: 6000, description: ''),
      PizzaModel(id: 3, title: "Pizza au fromage", image: "assets/images/p3.png", price: 20000, description: ''),
      PizzaModel(id: 4, title: "Pizza au tomate", image: "assets/images/p4.png", price: 7000, description: ''),
      PizzaModel(id: 5, title: "Pizza au poulet", image: "assets/images/p5.png", price: 10000, description: ''),
      PizzaModel(id: 6, title: "Pizza au champignon", image: "assets/images/p6.png", price: 15000, description: ''),
    ];

    _animController.forward();
    _animController2.forward();

    Provider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.4,
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
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
                _goCartPage();
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child:  Container(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Hero(
                    tag: 'saucer$_slideIndex',
                    child: Container(
                      child: AnimatedBuilder(
                        animation: _notifier, 
                        builder: (BuildContext context, Widget child) => Transform.rotate(
                          angle: math.pi*_notifier.value/4,
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              child: Image.asset('assets/images/saucer.png', fit: BoxFit.cover,),
                              width: 300,
                              height: 300,
                            ),
                          )
                        ),
                      ),
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: bodyColor,
                        shape: BoxShape.circle,
                        boxShadow: getShadow(),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),

          PizzaSlide(
            scrollPhysics: NeverScrollableScrollPhysics(),
            pageController: _pageController,
            viewportFraction: 0.5,
            notifier: _notifier,
            onPageChanged: (i) {
              setState(() {
                this._slideIndex = i+1;
                pizza.forEach((f) {
                  if(f.id == this._slideIndex) {
                    this._currentPrice = f.price;
                    this._currentTitle = f.title;
                  }
                });
              });
            },
            height: height,
            realPage: pizza.length,
            items: pizza.map((v) {
              return  SingleChildScrollView(
                child: GestureDetector(
                  child: Hero(
                    tag: 'orderDetail${v.id}',
                    child: _slideIndex == null
                    ?
                      AnimatedBuilder(
                        animation: _notifier,
                        builder: (BuildContext context, Widget child) { 
                          return Transform.rotate(
                            // angle: animation.value-math.pi / 3,
                            angle: 4*(math.pi*_notifier.value)/2,
                            child: v.id == 6 
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(v.image)
                                    )
                                  ),
                                  height: height*.47,
                                  width: 200,
                                )
                              :
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(v.image)
                                    )
                                  ),
                                  height: height*.47,
                                  width: 130,
                                )
                          );
                        },
                      )
                    : 
                      AnimatedBuilder(
                        animation: _notifier,
                        builder: (BuildContext context, Widget child) { 
                          return Transform.rotate(
                            // angle: animation.value-math.pi / 3,
                            angle: 2*(math.pi*_notifier.value)/2,
                            child: v.id == _slideIndex 
                              ? Transform.scale(
                                  scale: _notifier.value.clamp(0.1, 1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(v.image)
                                      )
                                    ),
                                    height: height*.47,
                                    width: 200,
                                  ),
                                )
                              :
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(v.image)
                                    )
                                  ),
                                  height: height*.47,
                                  width: 130,
                                )
                          );
                        },
                      )
                  ),

                  onTap: () {
                    _goPizzaDetailPage(context, v);
                  },

                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swiping in right direction
                      // print('swipe in right');
                      _pageController.previousPage(duration: Duration(milliseconds: 1500), curve: Curves.fastOutSlowIn);
                    }else {
                      // print('swipe in left');
                      _pageController.nextPage(duration: Duration(milliseconds: 1500), curve: Curves.fastOutSlowIn);
                    }
                  }
                ),
              );}
            ).toList()
          ),
         
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: height*0.58,),
                AnimatedBuilder(
                  animation: _animController2, 
                  builder: (BuildContext context, Widget child) => AnimatedOpacity(
                    opacity: animation3.value, 
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('$_currentTitle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            Text('${price.format(_currentPrice)}', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor)),
                          ],
                        ),
                        height: 150.0,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.rectangle,
                          color: bodyColor,
                          boxShadow: getShadow(),
                        ),
                      ),
                    ),
                  )
                )
              ],
            )
          ),
          
        ],
      )
    );
  }
}
