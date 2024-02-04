import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class NoteTitleEntry extends StatelessWidget {
  final _textFieldController;

  NoteTitleEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(0),
        counter: null,
        counterText: "",
        hintText: 'Title',
        hintStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          height: 1.5,
        ),
      ),
      maxLength: 31,
      maxLines: 1,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        height: 1.5,
        // color: Color(c1),
      ),
      textCapitalization: TextCapitalization.words,
    );
  }
}

class NoteEntry extends StatelessWidget {
  final _textFieldController;

  NoteEntry(this._textFieldController);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: _textFieldController,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        decoration: null,
        style: TextStyle(
          fontSize: 19,
          height: 1.5,
        ),
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField(
      {super.key,
      required TextEditingController emailController,
      required String hintText,
      required IconData iconName,
      required bool isBorderLine,
      required TextAlign textAlign,
      required bool isMultiLine,
      required double width})
      : _emailController = emailController,
        _hintText = hintText,
        _iconName = iconName,
        _isBorderLine = isBorderLine,
        _textAlign = textAlign,
        _isMultiLine = isMultiLine,
        _width = width;

  final TextEditingController _emailController;
  final String _hintText;
  final IconData _iconName;
  final bool _isBorderLine;
  final TextAlign _textAlign;
  final bool _isMultiLine;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      margin: new EdgeInsets.symmetric(horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0),
        child: TextFormField(
          controller: _emailController,
          maxLines: _isMultiLine ? 10 : 1,
          decoration: InputDecoration(
            hintText: _hintText,
            border: _isBorderLine == true
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                : null,
            icon: _isBorderLine == false ? Icon(_iconName) : null,
          ),
          textDirection: TextDirection.rtl,
          textAlign: _textAlign,
          // style: new TextStyle(fontFamily: "Hacen"),
        ),
      ),
    );
  }
}
