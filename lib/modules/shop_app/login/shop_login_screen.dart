import 'package:abdullah_mansour/modules/shop_app/login/cubit/shop_cubit.dart';
import 'package:abdullah_mansour/modules/shop_app/register/shop_register_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/shop_states.dart';

class ShopLoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.shopModel.status){
              showToast(text: state.shopModel.message, color: Colors.green,);
              // print(state.shopModel.message);
              // print(state.shopModel.data.token);
            } else{
              showToast(text: state.shopModel.message, color: Colors.amber,);
              // print(state.shopModel.message);
            }
          }
          else if(state is ShopLoginErrorState){
            showToast(text: state.error, color: Colors.red,);
          }
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
                              if (_formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
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
                              if (_formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
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
}
