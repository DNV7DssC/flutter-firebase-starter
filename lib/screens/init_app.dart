import 'package:firebasestarter/screens/home.dart';
import 'package:firebasestarter/services/dynamic_links/dynamic_links_handler.dart';
import 'package:flutter/material.dart';
import 'package:firebasestarter/bloc/init_app/init_app_bloc.dart';
import 'package:firebasestarter/bloc/init_app/init_app_event.dart';
import 'package:firebasestarter/bloc/init_app/init_app_state.dart';
import 'package:firebasestarter/bloc/login/login_bloc.dart';
import 'package:firebasestarter/bloc/login/login_event.dart';
import 'package:firebasestarter/bloc/login/login_state.dart';
import 'package:firebasestarter/screens/auth/login_screen.dart';
import 'package:firebasestarter/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DetermineAccessScreen extends StatefulWidget {
  @override
  _DetermineAccessScreenState createState() => _DetermineAccessScreenState();
}

class _DetermineAccessScreenState extends State<DetermineAccessScreen> {
  LoginBloc _bloc;
  InitAppBloc _initAppBloc;
  FirebaseEmailLinkHandler _emailLinkHandler;
  @override
  void initState() {
    super.initState();
    _initAppBloc = InitAppBloc();
    _initAppBloc.add(const IsFirstTime());
  }

  @override
  void didChangeDependencies() async {
    _bloc = BlocProvider.of<LoginBloc>(context);
    await _emailLinkHandler
        .init()
        .then((_) => _bloc.add(const CheckIfUserIsLoggedIn()));
    _bloc.add(const CheckIfUserIsLoggedIn());
    super.didChangeDependencies();
  }

  Widget _checkIfUserIsLoggedIn() => BlocBuilder<LoginBloc, LoginState>(
        cubit: _bloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoggedIn:
              return HomeScreen((state as LoggedIn).currentUser);
            default:
              return LoginScreen();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    _emailLinkHandler = GetIt.I<FirebaseEmailLinkHandler>();
    return BlocBuilder<InitAppBloc, FirstTimeInAppState>(
      cubit: _initAppBloc,
      builder: (context, initAppState) {
        switch (initAppState.runtimeType) {
          case FirstTime:
            return OnBoardingScreen();
          case NoFirstTime:
            return _checkIfUserIsLoggedIn();
          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
