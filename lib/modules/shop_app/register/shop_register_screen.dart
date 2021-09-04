import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/shop_layout.dart';
import 'package:abdullah_mansour/modules/shop_app/register/cubit/register_cubit.dart';
import 'package:abdullah_mansour/modules/shop_app/register/cubit/register_states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState){
            if(state.shopModel.status){
              print('ShopRegisterScreen token var: $token');
              print('ShopRegisterScreen: token after register: ${state.shopModel.data.token}');
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
        },
        builder: (context, state){
          ShopRegisterCubit _cubit = ShopRegisterCubit.get(context);

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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Create a new account and enjoy',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          validFun: (String value) {
                            if (value.isEmpty)
                              return 'please enter your name';
                            return null;
                          },
                          text: 'User Name',
                          keyBoardType: TextInputType.name,
                          controller: _nameController,
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
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
                            isPassword: _cubit.isPasswordVisible,
                            validFun: (String value) {
                              if (value.isEmpty)
                                return 'please enter your Password';
                              return null;
                            },
                            text: 'Password',
                            keyBoardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            prefix: Icons.lock,
                            suffix: _cubit.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixPressed: () {
                              _cubit.changePasswordVisibility();
                            },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          validFun: (String value) {
                            if (value.isEmpty)
                              return 'please enter your phone';
                            return null;
                          },
                          onSubmit: (value){
                            // _submit(context);
                          },
                          text: 'Phone',
                          keyBoardType: TextInputType.number,
                          controller: _phoneController,
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: ('Register'),
                            onPress: () {
                               _submit(context);
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
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
      ShopRegisterCubit.get(context).userRegister(
        email: _emailController.text,
        phone: _phoneController.text,
        name: _nameController.text,
        password: _passwordController.text,
      );
    }
  }

}
