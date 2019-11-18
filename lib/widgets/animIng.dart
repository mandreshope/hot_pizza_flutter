import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimIng extends StatefulWidget {
  AnimIng({Key key, this.anim}) : super(key: key);

  final int anim;

  _AnimIngState createState() => _AnimIngState();
}

class _AnimIngState extends State<AnimIng> with SingleTickerProviderStateMixin {

  AnimationController _animController;
  Animation<double> animation, animation2, animation3, animation4, animation5, animation6;

  @override
  void initState() {
    super.initState();

     _animController = new AnimationController(
      duration: const Duration(milliseconds: 800), 
      vsync: this,
	  );

    animation = Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve:  Curves.linear,
      ),
    );

    animation2 = Tween(begin: 5.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.3, 1.0, curve: Curves.linear), 
      ),
    );

    animation3 = Tween(begin: 5.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.9, 1.0, curve: Curves.linear), 
      ),
    );

    animation4 = Tween(begin: 5.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.1, 1.0, curve: Curves.linear), 
      ),
    );

    animation5 = Tween(begin: 5.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.8, 1.0, curve: Curves.linear), 
      ),
    );

    animation6 = Tween(begin: 5.0, end: 1.0).animate(
      new CurvedAnimation(
          parent: _animController,
          curve: Interval(0.9, 1.0, curve: Curves.linear), 
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    _animController.forward();
    return 
    AnimatedBuilder(
      animation: _animController, 
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          origin: Offset(widget.anim.toDouble(), -110),
          angle: widget.anim.toDouble()-math.pi / 4,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Transform(
                      transform: Matrix4.translationValues(animation.value * (width*0.3), animation.value * (height), 0.0),
                      child: Transform.scale(
                        scale: animation2.value == 1 ? 1 : animation2.value,
                        child: Container(
                          height: 20,
                          child: Image.asset('assets/images/ing/n${widget.anim}.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 50, height: 50,),
                    Transform(
                      transform: Matrix4.translationValues(animation.value * (width), animation.value * (height), 0.0),
                      child: Transform.scale(
                        scale: animation3.value == 1 ? 1 : animation3.value,
                        child: Container(
                          height: 20,
                          child: Image.asset('assets/images/ing/n${widget.anim}.png'),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Positioned(
                left: 100,
                top: 70,
                child: Row(
                  children: <Widget>[
                    Transform(
                      transform: Matrix4.translationValues(-animation.value * (width), animation.value * (height), 0.0),
                      child: Transform.scale(
                        scale: animation4.value == 1 ? 1 : animation4.value,
                        child: Container(
                          height: 20,
                          child: Image.asset('assets/images/ing/n${widget.anim}.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 50, height: 50,),
                    Transform(
                      transform: Matrix4.translationValues(-animation5.value * (width), -animation5.value * (height), 0.0),
                      child: Transform.scale(
                        scale: animation.value == 1 ? 1 : animation.value,
                        child: Container(
                          height: 20,
                          child: Image.asset('assets/images/ing/n${widget.anim}.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 30, height: 30,),
                    Transform(
                      transform: Matrix4.translationValues(animation.value * (width), animation.value * (height), 0.0),
                      child: Transform.scale(
                        scale: animation6.value == 1 ? 1 : animation6.value,
                        child: Container(
                          height: 20,
                          child: Image.asset('assets/images/ing/n${widget.anim}.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        );
      },

    );
  }
}