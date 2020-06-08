import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

import 'constants/fonts_constants.dart';

Widget btnWithIcon( 
  { String title, 
    Function onPressed,
    Color background,
    Color textColor,
    IconData icon 
  }
) {
  return RaisedButton.icon(
    onPressed: onPressed,

    color: background,
    textColor: textColor,
    padding: EdgeInsets.symmetric( horizontal: 20, vertical: 7 ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular( 20 )
    ),
    icon: FaIcon( 
      // FontAwesomeIcons.googlePlusG,
      icon,
      color: textColor,
    ),
    label: Text( 
      title,
      style: FontsConstants.styleLogin,
    ),
  );

}

Widget inputText( {
  IconData icon,
  String placeHolder
} ) {
  return Container(
    padding: EdgeInsets.symmetric( horizontal: 15 ),
    child: TextField(
      style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 17
        ),
        icon: FaIcon( icon, color: Colors.blueGrey ),
        hintText: placeHolder,
      ),
    ),
  );

}

Widget signInButtons(
  {
    String title,
    IconData icon,
    bool isGoogle = false,
    Color backgroundColor,
    Color colorIcon,
    Function onPressed
  }
) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      highlightElevation: 0,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isGoogle 
            ? Image(image: AssetImage("assets/images/google_logo.png"), height: 27.0)
            : FaIcon( icon, color: colorIcon, ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: FontsConstants.styleLogin
              ),
            )
          ],
        ),
      ),
    );
  }