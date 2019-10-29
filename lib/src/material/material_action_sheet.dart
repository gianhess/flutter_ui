import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MActionSheet {
  static show(
      {@required BuildContext context,
        @required Function callback,
        @required String title,
        @required String subTitle}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(title),
          message: Text(subTitle),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Yes'),
              isDefaultAction: true,
              onPressed: () => callback(),
            ),
            CupertinoActionSheetAction(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, 'No');
              },
            )
          ],
        ));
  }

  static showCustom(
      {@required BuildContext context,
        @required List<MAction> actions,
        @required String title,
        @required String subTitle,
        bool hasCancel = false}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(title),
          message: Text(subTitle),
          actions: _buildActions(context, actions, hasCancel),
        ));
  }

  static List<Widget> _buildActions(
      BuildContext context, List<MAction> actions, bool hasCancel) {
    List<Widget> list = List<Widget>();
    for (var action in actions) {
      list.add(CupertinoActionSheetAction(
          onPressed: action.pressCallback, child: Text(action.title)));
    }

    if (hasCancel) {
      list.add(CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ));
    }

    return list;
  }
}

class MAction {
  String title;
  Function pressCallback;

  MAction({this.title, this.pressCallback});
}
