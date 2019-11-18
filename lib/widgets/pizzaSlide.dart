import 'package:flutter/material.dart';

class PizzaSlide extends StatefulWidget {

  final ValueNotifier<double> notifier;
  final List<Widget> items;
  final double height;
  final int initialPage;
  final bool enableInfiniteScroll;
  final Function(int index) onPageChanged;
  final PageController pageController;
  final num realPage;
  final double viewportFraction;

  PizzaSlide({
    this.notifier,
    @required this.items,
    this.height,
    this.viewportFraction: 0.8,
    this.initialPage: 0,
    this.enableInfiniteScroll: true,
    this.onPageChanged,
    int realPage: 1000
  }): this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
    this.pageController = PageController(
      initialPage: enableInfiniteScroll ? realPage + initialPage : initialPage,
      viewportFraction: viewportFraction
    );


  @override
  _PizzaSlideState createState() => _PizzaSlideState();
}

class _PizzaSlideState extends State<PizzaSlide> {

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      onPageChanged: (int index) {
        int currentPage = _getRealIndex(index + widget.initialPage, widget.realPage, widget.items.length);
        if (widget.onPageChanged != null) {
          widget.onPageChanged(currentPage);
        }
      },
      
      itemBuilder: (BuildContext context, int i) {
        final int index = _getRealIndex(i + widget.initialPage, widget.realPage, widget.items.length);
        return AnimatedBuilder(
          animation: widget.pageController,
          builder: (context,child){
            if (widget.pageController.position.minScrollExtent == null ||
                widget.pageController.position.maxScrollExtent == null) {
              Future.delayed(Duration(microseconds: 1), () {
                setState(() {});
              });
              return Container();
            }
            widget.pageController.addListener((){
              widget.notifier.value = widget.pageController.page;
            });
            print(widget.notifier.value);
            double value = widget.pageController.page - i;
            value = (1-(value.abs()*.4)).clamp(0.0, 1.0);
            return Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: Curves.linear.transform(value) * widget.height,
                  child: child,
                ),
              ],
            );
          },
          child: widget.items[index],
        );
      },

    );
  }

  int _getRealIndex(int position, int base, int length) {
    final int offset = position - base;
    return _remainder(offset, length);
  }
  
  int _remainder(int input, int source) {
    final int result = input % source;
    return result < 0 ? source + result : result;
  }

}