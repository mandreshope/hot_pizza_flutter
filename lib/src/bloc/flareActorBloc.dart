import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';

class FlareActorBloc with ChangeNotifier {

  bool isAnimated = false;

  bool get getIsAnimated => isAnimated;

  setIsAnimated(bool val) {
    isAnimated = val;
    notifyListeners();
  }


  boxPizzaFlareActor(bool isAnimated) {
    return FlareActor('assets/box_pizza_anim.flr', 
      fit: BoxFit.cover,
      animation: isAnimated ? 'animate' : 'hidde',
    );
    // notifyListeners();
  }

}