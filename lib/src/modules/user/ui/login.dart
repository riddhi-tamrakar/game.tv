import 'package:app/src/locale/app_translations.dart';
import 'package:app/src/modules/home/ui/home.dart';
import 'package:app/src/modules/user/bloc/user_bloc.dart';
import 'package:app/src/services/utility.dart';
import 'package:app/src/widgets/app_logo_widget.dart';
import 'package:app/src/widgets/common_button_widget.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/input_field_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../styles/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserBloc _bloc = UserBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  String username;
  String password;
  bool showPassword = false;

  void initState() {
    super.initState();
    _bloc.add(InitLogin());
  }

  void _login() async {
    _bloc.add(PerfomLogin(
      email: username,
      password: password,
    ));
  }

  Widget _buildUsernameField() => InputFieldWidget(
        label: AppTranslations.of(context).text('username'),
        keyboardType: TextInputType.emailAddress,
        hintText: AppTranslations.of(context).text('username_hint'),
        errorText:
            AppTranslations.of(context).text('username_validation_error'),
        onSaved: (value) => username = value,
      );

  Widget _buildPasswordField() => InputFieldWidget(
        obscureText: true,
        label: AppTranslations.of(context).text('password'),
        hintText: AppTranslations.of(context).text('password_hint'),
        errorText:
            AppTranslations.of(context).text('password_validation_error'),
        onSaved: (value) => password = value,
      );

  Widget _buildLoginBtn(UserState state) => CommonButtonWidget(
        buttonText: AppTranslations.of(context).text('login'),
        isLoading: state is Loading ? true : false,
        onTap: (val) {
          Utility.closeKeyboard(context);
          if (state is Loading) {
          } else {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _login();
            }
          }
        },
      );

  Widget _loginSection(UserState state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.kBodyPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpacerWidget(AppTheme.kBodyPadding * 3),
            Align(alignment: Alignment.center, child: AppLogoWidget()),
            SpacerWidget(AppTheme.kBodyPadding * 3),
            Text(
              AppTranslations.of(context).text('login'),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppTheme.kFontColor1),
            ),
            SpacerWidget(6),
            Text(
              AppTranslations.of(context).text('login_subtitle'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SpacerWidget(AppTheme.kBodyPadding * 2),
            Container(
              child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildUsernameField(),
                      SpacerWidget(AppTheme.kBodyPadding),
                      _buildPasswordField(),
                      SpacerWidget(AppTheme.kBodyPadding * 2),
                      _buildLoginBtn(state)
                    ],
                  )),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Utility.upliftPage(context, _scrollController);

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {},
      child: Scaffold(
          key: _scaffoldKey,
          body: ListView(
            padding: EdgeInsets.zero,
            controller: _scrollController,
            children: [
              BlocBuilder(
                  bloc: _bloc,
                  builder: (BuildContext context, UserState state) {
                    if (state is UserInitial) {
                      return Container(
                          margin: EdgeInsets.only(
                              top: Utility.displayHeight(context) * 0.40),
                          padding: EdgeInsets.all(AppTheme.kBodyPadding),
                          color: Theme.of(context).backgroundColor,
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/logo.jpeg',
                                  fit: BoxFit.cover)));
                    } else if (state is LoginSuccess) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _loginSection(state);
                    }
                  }),
              BlocListener<UserBloc, UserState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is InvalidCredentials) {
                    Utility.showSnackBar(
                        _scaffoldKey,
                        AppTranslations.of(context).text('invalid_credentials'),
                        context);
                  }
                  if (state is LoginSuccess) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                  if (state is ErrorReceived) {
                    if (state.err != null && state.err != "") {
                      Utility.showSnackBar(
                          _scaffoldKey, "${state.err}", context);
                    }
                  }
                },
                child: Container(),
              )
            ],
          )),
    );
  }
}
