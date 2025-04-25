import 'package:flutter/material.dart';
import 'package:flutter_alice/model/alice_http_call.dart';
import 'package:flutter_alice/ui/widget/alice_base_call_details_widget.dart';

class AliceCallErrorWidget extends StatefulWidget {
  final AliceHttpCall call;

  AliceCallErrorWidget(this.call);

  @override
  State<StatefulWidget> createState() {
    return _AliceCallErrorWidgetState();
  }
}

class _AliceCallErrorWidgetState
    extends AliceBaseCallDetailsWidgetState<AliceCallErrorWidget> {
  AliceHttpCall get _call => widget.call;

  @override
  Widget build(BuildContext context) {
    if (_call.error != null) {
      List<Widget> rows = [];
      var error = _call.error!.error;
      var errorText = "Error is empty";
      if (error != null) {
        errorText = error.toString();
      }
      rows.add(getListRow("Error:", errorText));

      return Container(
        padding: EdgeInsets.all(6),
        child: ListView(children: rows),
      );
    } else {
      return Center(child: Text("Nothing to display here"));
    }
  }
}
