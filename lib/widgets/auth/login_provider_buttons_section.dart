import 'package:firebasestarter/bloc/login/login_bloc.dart';
import 'package:firebasestarter/bloc/login/login_event.dart';
import 'package:firebasestarter/constants/assets.dart';
import 'package:firebasestarter/widgets/auth/auth_service_button.dart';
import 'package:firebasestarter/widgets/common/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

class LoginProviderButtonsSection extends StatelessWidget {
  static const _text = 'text';
  static const _asset = 'asset';
  static const _onTap = 'onTap';
  static const _last = 'last';

  final LoginBloc bloc;

  const LoginProviderButtonsSection(this.bloc);

  List<Map<String, dynamic>> _buttonsData(context) {
    final _localizedStrings = AppLocalizations.of(context);
    return [
      {
        _text: _localizedStrings.googleSignIn,
        _asset: Assets.googleLogo,
        _onTap: () => bloc.add(const GoogleLoginStarted()),
        _last: false,
      },
      {
        _text: _localizedStrings.facebookSignIn,
        _asset: Assets.facebookLogo,
        _onTap: () => bloc.add(const FacebookLoginStarted()),
        _last: false,
      },
      if (!Platform.isAndroid)
        {
          _text: _localizedStrings.appleIdSignIn,
          _asset: Assets.appleLogo,
          _onTap: () => bloc.add(const AppleLoginStarted()),
          _last: false,
        },
      {
        _text: _localizedStrings.anonymousSignIn,
        _asset: Assets.anonLogin,
        _onTap: () => bloc.add(const AnonymousLoginStarted()),
        _last: true,
      }
    ];
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          for (final info in _buttonsData(context)) ...[
            AuthServiceButton(
              text: info[_text],
              backgroundColor: Colors.white,
              textColor: Colors.black,
              asset: info[_asset],
              onTap: info[_onTap],
            ),
            !info[_last]
                ? Margin(0.0, 14.0)
                : const SizedBox(height: 0.0, width: 0.0),
          ]
        ],
      );
}
