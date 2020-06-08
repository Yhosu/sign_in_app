import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_app/src/services/usuario_services.dart';
import 'package:sign_in_app/src/utils/constants/fonts_constants.dart';
import 'package:sign_in_app/src/utils/utils_sign.dart' as utils;
import 'package:google_sign_in/google_sign_in.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'profile',
    'email'
  ]
);

class LoginPage extends StatefulWidget {


  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount _currentUser;

  // @override
  // void initState() { 
  //   super.initState();
  //   try {
  //     _googleSignIn.onCurrentUserChanged.listen( ( GoogleSignInAccount account ) {
  //       setState(() {
  //         _currentUser = account;
  //       });
  //     } );
  //   }
  //   _googleSignIn.signInSilently();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: _currentUser != null 
        ? Column(
          children: <Widget>[
            ListTile(
              leading: GoogleUserCircleAvatar(
                identity: _currentUser,
              ),
              title: Text( _currentUser.displayName ?? '' ),
              subtitle: Text( _currentUser.email ?? '' ),
            ),
            RaisedButton(
              onPressed: _handleSignOut,
              child: Text( 'out' ),
            )
          ],
        )
        : Center(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _backgroundTheme(),

            _backgroundLoginPage(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 150,
                    ),
                  ),
                  _showCardSign(size),
                  Text( 
                    'O ingresa con:',
                    style: FontsConstants.styleLogin,
                  ),

                  SizedBox( height: 15.0,),
                  _signInMethods(),


                ],
              ),
            )
            // _signInMethods()
          ],
        ),
      ),
    );
  }

  Future<void>_handleSignOut () async {
    _googleSignIn.disconnect();
  }

  Future<void> _handleSingIn() async {
    try {
      await _googleSignIn.signIn().then( ( result ) {
        result.authentication.then( ( googlekey) {
          print( 'ACCES: ${googlekey.accessToken}' );
          print( 'TOKEN: ${googlekey.idToken}' ); 
        });
      });

    } catch( error) {
      print( 'Error: $error' );
    }
  }

  Widget _showCardSign(Size size) {
    return Stack(
      children: <Widget>[
        Container(
          width: size.width * 0.80,
          padding: EdgeInsets.symmetric(vertical: 45),
          margin: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity( 0.7 ),
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 5.0)
              ]),
          child: Column(
            children: <Widget>[
              utils.inputText(
                  icon: FontAwesomeIcons.envelope, 
                  placeHolder: 'Email'
              ),
              SizedBox(
                height: 15,
              ),
              utils.inputText(
                  icon: FontAwesomeIcons.key, 
                  placeHolder: 'Contraseña',
              ),
              SizedBox( height: 30,),
              RaisedButton(
                color: Color.fromRGBO(255, 87, 35, 1 ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular( 5.0 )
                ),
                padding: EdgeInsets.symmetric( horizontal: 25.0, vertical: 10),
                onPressed: () {},
                child: Text( 
                  'Ingresar',
                  style: FontsConstants.styleLogin,
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: ( size.width * 0.66 ) / 2,
          top: 4,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey,
            child: FaIcon( 
              FontAwesomeIcons.solidUserCircle, 
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _backgroundLoginPage() {
    return Image(
        image: AssetImage( 'assets/images/bk-login.png' ),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      );
  }

  Widget _signInMethods() {
    final usuarioProvider = UsuarioProvider();
    
    return Column(
      children: <Widget>[
        utils.signInButtons(
          isGoogle: true,
          title: 'Google',
          backgroundColor: Color.fromRGBO( 255, 255, 255, 0.2 ),
          onPressed: () {
            print( 'antes' );
            _handleSingIn();
            print( 'ahora' );
          }
        ),
        SizedBox( height: 10.0 ),
        utils.signInButtons(
          title: 'Facebook',
          icon: FontAwesomeIcons.facebookF,
          colorIcon: Colors.white,
          backgroundColor: Colors.blue[900].withOpacity( 0.6 ),
          onPressed: (){}
        ),
        SizedBox( height: 10.0 ),
        utils.signInButtons(
          title: 'Teléfono',
          icon: FontAwesomeIcons.phoneAlt,
          backgroundColor: Colors.black87.withOpacity( 0.6 ),
          colorIcon: Colors.white,
          onPressed: (){}
        ),
    
      ],
    );
  }
}
