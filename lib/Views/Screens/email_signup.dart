import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../Controllers/internet_controller.dart';
import '../../Controllers/sign_in_controller.dart';
import '../Widgets/snackBar.dart';
import 'about_you.dart';
import 'email_signup_m.dart';
import 'email_signup_w.dart';

class EmailSignup extends StatelessWidget {
  const EmailSignup({super.key});
  static const routeName = '/EmailSignup';

  @override
  Widget build(BuildContext context) {
    return (kIsWeb) ? const EmailSignupW() : const EmailSignupM();
  }
}

Future<void> submitSignup(
    emailController, userNameController, passwordController, context) async {
  final sp = context.read<SignInController>();
  final ip = context.read<InternetController>();
  await ip.checkInternetConnection();

  if (ip.hasInternet == false) {
    // ignore: use_build_context_synchronously
    showSnackBar("Check your Internet connection", context);
  } else {
    await sp
        .signUp(emailController.text, userNameController.text,
            passwordController.text)
        .then((value) {
      if (sp.hasError == true) {
        showSnackBar(sp.errorCode.toString(), context);
      }
    });
  }
  Navigator.of(context).pushReplacementNamed(AboutYou.routeName, arguments: {});
}
