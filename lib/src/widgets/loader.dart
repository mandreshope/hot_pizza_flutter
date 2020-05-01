import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';

class Loader extends StatelessWidget {
  final object;
  final Function callback;

  Loader({@required this.object, @required this.callback});

  @override
  Widget build(BuildContext context) {
    if (object == null)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: FlareActor('assets/pizza_loading_animation.flr',
                fit: BoxFit.cover,
                animation: 'Pizza Bounce',
              ),
            ),
            Text("Chargement..."),
          ],
        )
      );

    if (object.length == 0)
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: FlareActor('assets/pizza_loading_animation.flr',
                fit: BoxFit.cover,
                animation: 'Pizza Bounce',
              ),
            ),
            Text("Aucun élément trouvé"),
          ],
        )
      );

    return callback();
  }
}