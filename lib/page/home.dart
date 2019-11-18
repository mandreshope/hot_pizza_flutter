import 'package:flutter/material.dart';
import 'package:hot_pizza/model/pizza.dart';
import 'package:hot_pizza/page/pizzaDetail.dart';
import 'package:hot_pizza/widgets/pizzaSlide.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  int _slideIndex = 1;
  int _currentPrice;
  String _currentTitle; 
  List<Pizza> pizza = [];

  ValueNotifier<double> _notifier = ValueNotifier(0.0);
  AnimationController _animController;
  AnimationController _animController2;
  Animation<double> animation, animation3;

  void _goPizzaDetailPage(BuildContext context, v) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PizzaDetailPage(pizza: v,)
      )
    ).then((onValue){
      print(onValue);
      _animController.repeat();
      _animController2.repeat();
    });
  }

  @override
  void initState() {
    super.initState();
    
    pizza.add(Pizza(id: 1, title: "Pizza olive", image: "assets/images/p1.png", price: 10000, description: ''));
    pizza.add(Pizza(id: 2, title: "Pizza legume", image: "assets/images/p2.png", price: 6000, description: ''));
    pizza.add(Pizza(id: 3, title: "Pizza au fromage", image: "assets/images/p3.png", price: 20000, description: ''));
    pizza.add(Pizza(id: 4, title: "Pizza au tomate", image: "assets/images/p4.png", price: 7000, description: ''));
    pizza.add(Pizza(id: 5, title: "Pizza au poulet", image: "assets/images/p5.png", price: 10000, description: ''));
    pizza.add(Pizza(id: 6, title: "Pizza au champignon", image: "assets/images/p6.png", price: 15000, description: ''));
    _currentTitle = pizza[0].title;
    _currentPrice = pizza[0].price;


    _animController = new AnimationController(
      duration: const Duration(milliseconds: 1000), 
      vsync: this,
	  );

    _animController2 = new AnimationController(
      duration: const Duration(milliseconds: 1500), 
      vsync: this,
	  );

    animation = Tween(begin: 1.0, end: 0.1).animate(
      new CurvedAnimation(
          parent: _animController,
          curve:  Curves.easeIn,
      ),
    );

    animation3 = Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
          parent: _animController2,
          curve: Curves.fastOutSlowIn
      ),
    );

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
    _animController.forward();
     _animController2.forward();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.4,
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.black, offset: Offset(0, 2), blurRadius: 5,),
                  BoxShadow(color: Colors.white, spreadRadius: 2),
                ],
              ),
              width: 260,
              height: height*0.65,
            )
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                AnimatedBuilder(
                  animation: _notifier, 
                  builder: (BuildContext context, Widget child) => Transform.rotate(
                    angle: -_notifier.value-math.pi / 6,
                    child: Container(
                      child: Image.asset('assets/images/backgroud.png'),
                      width: 260,
                      height: 260,
                    ),
                  ),
                )
              ],
            )
          ),

          Positioned(
            top: 6,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'board$_slideIndex',
                  child: AnimatedBuilder(
                    animation: _notifier, 
                    builder: (BuildContext context, Widget child) => Transform.rotate(
                      angle: 2*math.pi*_notifier.value,
                      child: Container(
                        child: Image.asset('assets/images/board.png'),
                        width: 200,
                        height: height*0.45,
                      ),
                    ),
                  )
                  
                ),
                
              ],
            )
          ),

          PizzaSlide(
            notifier: _notifier,
            onPageChanged: (i) {
              _animController.repeat();
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
            viewportFraction: 0.5,
            items: pizza.map((v) => SingleChildScrollView(
                child: GestureDetector(
                  child: Hero(
                    tag: 'orderDetail${v.id}',
                    child: v.id == _slideIndex
                    ?
                      AnimatedBuilder(
                        animation: _notifier,
                        builder: (BuildContext context, Widget child) => Transform.rotate(
                          // angle: animation.value-math.pi / 3,
                          angle: 2*_notifier.value-math.pi / 6,
                          child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(v.image)
                            )
                          ),
                          height: height*.47,
                          width: 200,
                        ),
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
                        width: 200,
                      ),
                  ),
                  onTap: () {
                    _goPizzaDetailPage(context, v);
                  },
                ),
              )
            ).toList()
          ),
         
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: height*0.58,),
                AnimatedBuilder(
                  animation: _animController2, 
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
                            Text('$_currentTitle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Text('$_currentPrice ar'),
                            Divider(),
                            RaisedButton(
                              color: Colors.redAccent,
                              child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 28,),
                              onPressed: () {},
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
          
        ],
      )
    );
  }
}
