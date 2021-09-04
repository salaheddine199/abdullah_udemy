import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/shop_layout.dart';
import 'package:abdullah_mansour/modules/shop_app/login/cubit/shop_cubit.dart';
import 'package:abdullah_mansour/modules/shop_app/register/shop_register_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/shop_states.dart';

/// I used stateful because I need to destroy the controllers
/// there is no dif between stless and stful if we didn't setSate

class ShopLoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   final _emailController = TextEditingController();
  //   final _passwordController = TextEditingController();
  //   final _formKey = GlobalKey<FormState>();
  //   super.initState();
  // }

  /// it seems there is a prblm with this
  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _formKey.currentState.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.shopModel.status){

              //print('ShopLoginScreen token var: $token');
              //print('ShopLoginScreen: token after login: ${state.shopModel.data.token}');
              showToast(text: state.shopModel.message, color: Colors.green,);

              // Update the token we have( new login= new token ) :
              CacheHelper.setData(key: 'loginToken', value: state.shopModel.data.token).then((value) {
                token = state.shopModel.data.token;
                navigateToNoBack(context, ShopLayout());

                // because we don't do these methods at first ( no logged in)
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getCategories();
                ShopCubit.get(context).getFavorites();
                ShopCubit.get(context).getProfile();
              });


            } else{
              showToast(text: state.shopModel.message, color: Colors.red,);
              // print(state.shopModel.message);
            }
          }
          // else if(state is ShopLoginErrorState){
          //   showToast(text: state.error, color: Colors.redAccent,);
          // }
        },
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          validFun: (String value) {
                            if (value.isEmpty)
                              return 'please enter your email address';
                            return null;
                          },
                          onSubmit: (value){
                            _submit(context);
                          },
                          text: 'Email Address',
                          keyBoardType: TextInputType.emailAddress,
                          controller: _emailController,
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.isPasswordVisible,
                            validFun: (String value) {
                              if (value.isEmpty)
                                return 'please enter your Password';
                              return null;
                            },
                            onSubmit: (value){
                              _submit(context);
                            },
                            text: 'Password',
                            keyBoardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            prefix: Icons.lock,
                            suffix: cubit.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: ('login'),
                            onPress: () {
                              _submit(context);
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'register',
                              function: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(context){
    if (_formKey.currentState.validate()) {
      ShopLoginCubit.get(context).userLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}