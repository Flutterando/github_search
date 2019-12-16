import 'package:flutter/material.dart';

mixin ButtonAnimation<T extends StatefulWidget> on State<T> {
  final scrollController = ScrollController();
  void onAddButtomTap();

  void showButtom() {
    isVisible = true;
    _overlayEntry.markNeedsBuild();
  }

  void hideButtom() {
    isVisible = false;
    _overlayEntry.markNeedsBuild();
  }

  Duration animationDuration = Duration(milliseconds: 1000);
  bool isVisible = true;

  ButtonProperties get _bottomProperties {
    return scrollController.positions.isEmpty
        ? ButtonProperties(false)
        : ButtonProperties(scrollController.offset > 44);
  }

  OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry);
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => (!isVisible)
          ? Container()
          : Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
              ),
              child: AnimatedBuilder(
                animation: scrollController,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: animationDuration,
                    curve: Curves.easeOutExpo,
                    alignment: _bottomProperties.alignment,
                    padding: EdgeInsets.only(bottom: 15),                    
                    child: FittedBox(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        elevation: 4,
                        onPressed: onAddButtomTap,
                        shape: _bottomProperties.shape,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: _bottomProperties.padding,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add),
                              if (!_bottomProperties.isBottom)
                                SizedBox(width: 15),
                              // Padding(padding: EdgeInsets.only(left: 15)),
                              if (!_bottomProperties.isBottom)
                                Text("ADICIONAR USUARIO"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class ButtonProperties {
  final bool isBottom;

  Alignment get alignment {
    return isBottom ? Alignment.bottomRight : Alignment.topCenter;
  }

  double get padding {
    return isBottom ? 20 : 8;
  }

  ShapeBorder get shape {
    return isBottom
        ? CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          );
  }

  ButtonProperties(bool isBottom) : isBottom = isBottom;
}
