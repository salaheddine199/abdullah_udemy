import 'package:abdullah_mansour/layout/shop_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';
import 'package:abdullah_mansour/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        // if(state is ShopSuccessProfileState){
        //   _nameController.text = state.model.data.name;
        //   _emailController.text = state.model.data.email;
        //   _phoneController.text = state.model.data.phone;
        //   // it won't work cuz the states moves fast between each other
        //   // so it can't do the setters here
        // }
        if(state is ShopSuccessUpdateProfileState){
          showToast(text: 'Changed successfully', color: Colors.green);
        }
      },
      builder: (context, state){
        ShopLoginModel model = ShopCubit.get(context).userModel;
        _nameController.text = model.data.name;
        _emailController.text = model.data.email;
        _phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: model!= null, // && state is! ShopLoadingProfileState,
          builder:(context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state is ShopLoadingUpdateProfileState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormField(
                    validFun: (String value){
                      if(value.isEmpty)
                        return 'name must not be null';
                      return null;
                    },
                    text: 'Name: ',
                    keyBoardType: TextInputType.name,
                    controller: _nameController,
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                    validFun: (String value){
                      if(value.isEmpty)
                        return 'email must not be null';
                      return null;
                    },
                    text: 'Email: ',
                    keyBoardType: TextInputType.emailAddress,
                    controller: _emailController,
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                    validFun: (String value){
                      if(value.isEmpty)
                        return 'phone must not be null';
                      return null;
                    },
                    text: 'Phone: ',
                    keyBoardType: TextInputType.number,
                    controller: _phoneController,
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          text: 'Update',
                          onPress: (){

                            if(_formKey.currentState.validate()){

                              if(_nameController.text == model.data.name
                                  && _emailController.text == model.data.email
                                  && _phoneController.text == model.data.phone
                              ){
                                showToast(text: 'You did not change anything', color: Colors.amber);
                              }
                              else{
                                ShopCubit.get(context).updateProfile(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                );
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: defaultButton(
                          text: 'Reset',
                          bgColor: defaultColor.withOpacity(.7),
                          onPress: (){
                            _nameController.text = model.data.name;
                            _emailController.text = model.data.email;
                            _phoneController.text = model.data.phone;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                      text: 'Logout',
                      bgColor: Colors.red,
                      onPress: (){
                        _logout(context);
                      },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  _logout(context) {
    CacheHelper.removeData(key: 'loginToken').then((value) {
      if (value) navigateToNoBack(context, ShopLoginScreen());
    });
  }
}
