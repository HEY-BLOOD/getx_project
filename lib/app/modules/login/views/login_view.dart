import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';
import 'package:getx_project/app/data/network/services/api_service.dart';
import 'package:getx_project/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginView extends GetView<LoginController> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  BorderRadius get inputBorder => const BorderRadius.vertical(
        bottom: Radius.circular(10.0),
        top: Radius.circular(20.0),
      );
  Future<String?> _loginUser(LoginData data) async {
    debugPrint('Email: ${data.name}, Password: ${data.password}');
    Future? result =
        ApiService.instance?.login(email: data.name, password: data.password);
    return result?.then((response) {
      debugPrint("response: ${response.userId}");
      return null;
    }).catchError((error) {
      debugPrint("error: ${error.response['message']}");
      return error.response['message'];
    }).whenComplete(() => null);
    // return null;
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name)) {
    //     return 'User not exists';
    //   }
    //   if (users[data.name] != data.password) {
    //     return 'Password does not match';
    //   }
    //   return null;
    // });
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup email: ${data.name}, Password: ${data.password}');
    Future? result = ApiService.instance
        ?.signup(email: data.name!, password: data.password!);
    return result?.then((response) {
      debugPrint("response: ${response.toString()}");
      return null;
    }).catchError((error) {
      debugPrint("error: ${error.response['message']}");
      return error.response['message'];
    });
    // return Future.delayed(loginTime).then((_) {
    //   return null;
    // });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LoginView'),
      //   centerTitle: true,
      // ),
      body: FlutterLogin(
        title: 'GetX',
        logo: const AssetImage('assets/flutter.png'),
        // hideForgotPasswordButton: true,
        onLogin: (loginData) => _loginUser(loginData),
        onSignup: (signupData) => _signupUser(signupData),
        // onSubmitAnimationCompleted: () {},
        onRecoverPassword: (email) => _recoverPassword(email),
        onConfirmSignup: (string, data) {
          debugPrint("onConfirmSignup: $string");
        },
        // loginProviders: <LoginProvider>[
        //   LoginProvider(
        //     icon: FontAwesomeIcons.google,
        //     label: 'Google',
        //     callback: () async {
        //       debugPrint('start google sign in');
        //       await Future.delayed(loginTime);
        //       debugPrint('stop google sign in');
        //       return null;
        //     },
        //   ),
        //   LoginProvider(
        //     icon: FontAwesomeIcons.facebookF,
        //     label: 'Facebook',
        //     callback: () async {
        //       debugPrint('start facebook sign in');
        //       await Future.delayed(loginTime);
        //       debugPrint('stop facebook sign in');
        //       return null;
        //     },
        //   ),
        //   LoginProvider(
        //     icon: FontAwesomeIcons.linkedinIn,
        //     label: 'LinkedIn',
        //     callback: () async {
        //       debugPrint('start linkdin sign in');
        //       await Future.delayed(loginTime);
        //       debugPrint('stop linkdin sign in');
        //       return null;
        //     },
        //   ),
        //   LoginProvider(
        //     icon: FontAwesomeIcons.githubAlt,
        //     label: 'Github',
        //     callback: () async {
        //       debugPrint('start github sign in');
        //       await Future.delayed(loginTime);
        //       debugPrint('stop github sign in');
        //       return null;
        //     },
        //   ),
        // ],
        messages: loginMessage(),
        // theme: loginTheme(),
      ),
    );
  }

  LoginMessages loginMessage() {
    return LoginMessages(
        // userHint: 'Email',
        // passwordHint: 'Pass',
        // confirmPasswordHint: 'Confirm',
        // loginButton: 'LOG IN',
        // signupButton: 'REGISTER',
        // forgotPasswordButton: 'Forgot huh?',
        // recoverPasswordButton: 'HELP ME',
        // goBackButton: 'GO BACK',
        // confirmPasswordError: 'Not match!',
        // recoverPasswordDescription:
        //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        // recoverPasswordSuccess: 'Password rescued successfully',
        );
  }

  LoginTheme loginTheme() {
    return LoginTheme(
      primaryColor: Colors.teal,
      accentColor: Colors.yellow,
      errorColor: Colors.deepOrange,
      titleStyle: const TextStyle(
        color: Colors.greenAccent,
        fontFamily: 'Quicksand',
        letterSpacing: 4,
      ),
      bodyStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
      ),
      textFieldStyle: const TextStyle(
        color: Colors.orange,
        shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      ),
      buttonStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.yellow,
      ),
      cardTheme: CardTheme(
        color: Colors.yellow.shade100,
        elevation: 5,
        margin: const EdgeInsets.only(top: 15),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100.0)),
      ),
      inputTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.purple.withOpacity(.1),
        contentPadding: EdgeInsets.zero,
        errorStyle: const TextStyle(
          backgroundColor: Colors.orange,
          color: Colors.white,
        ),
        labelStyle: const TextStyle(fontSize: 12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
          borderRadius: inputBorder,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
          borderRadius: inputBorder,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 7),
          borderRadius: inputBorder,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          borderRadius: inputBorder,
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 5),
          borderRadius: inputBorder,
        ),
      ),
      buttonTheme: LoginButtonTheme(
        splashColor: Colors.purple,
        backgroundColor: Colors.pinkAccent,
        highlightColor: Colors.lightGreen,
        elevation: 9.0,
        highlightElevation: 6.0,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // shape: CircleBorder(side: BorderSide(color: Colors.green)),
        // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      ),
    );
  }
}
