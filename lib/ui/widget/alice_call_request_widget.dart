import 'package:flutter/material.dart';
import 'package:flutter_alice/model/alice_http_call.dart';
import 'package:flutter_alice/ui/widget/alice_base_call_details_widget.dart';

class AliceCallRequestWidget extends StatefulWidget {
  final AliceHttpCall call;

  AliceCallRequestWidget(this.call);

  @override
  State<StatefulWidget> createState() {
    return _AliceCallRequestWidget();
  }
}

class _AliceCallRequestWidget
    extends AliceBaseCallDetailsWidgetState<AliceCallRequestWidget> {
  AliceHttpCall get _call => widget.call;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    rows.add(getListRow("Started:", _call.request!.time.toString()));
    rows.add(getListRow("Bytes sent:", formatBytes(_call.request!.size)));
    rows.add(
        getListRow("Content type:", getContentType(_call.request!.headers)!));

    var body = _call.request!.body;
    String? bodyContent = "Body is empty";
    if (body != null) {
      bodyContent = formatBody(body, getContentType(_call.request!.headers));
    }
    rows.add(getListRow("Body:", bodyContent!));
    var formDataFields = _call.request!.formDataFields;
    if (formDataFields?.isNotEmpty == true) {
      rows.add(getListRow("Form data fields: ", ""));
      formDataFields!.forEach(
        (field) {
          rows.add(getListRow("   • ${field.name}:", "${field.value}"));
        },
      );
    }
    var formDataFiles = _call.request!.formDataFiles;
    if (formDataFiles?.isNotEmpty == true) {
      rows.add(getListRow("Form data files: ", ""));
      formDataFiles!.forEach(
        (field) {
          rows.add(getListRow("   • ${field.fileName}:",
              "${field.contentType} / ${field.length} B"));
        },
      );
    }

    var headers = _call.request!.headers;
    var headersContent = "Headers are empty";
    if (headers.length > 0) {
      headersContent = "";
    }
    rows.add(getListRow("Headers: ", headersContent));
    if (_call.request?.headers != null) {
      _call.request!.headers.forEach((header, value) {
        rows.add(getListRow("   • $header:", value.toString()));
      });
    }
    var queryParameters = _call.request!.queryParameters;
    var queryParametersContent = "Query parameters are empty";
    if (queryParameters.length > 0) {
      queryParametersContent = "";
    }
    rows.add(getListRow("Query Parameters: ", queryParametersContent));
    if (_call.request?.queryParameters != null) {
      _call.request!.queryParameters.forEach((query, value) {
        rows.add(getListRow("   • $query:", value.toString()));
      });
    }

    return Container(
      padding: const EdgeInsets.all(6),
      child: ListView(children: rows),
    );
  }
}
