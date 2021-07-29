import 'package:abdullah_mansour/modules/news_app/web_view/web_view_screen.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Widget defaultButton({
  @required String text,
  @required Function onPress,
  bool isUpperCase = true,
  double width = double.infinity,
  Color bgColor = Colors.teal,
  double radius = 10.0,
  EdgeInsets padding,
  EdgeInsets margin,
  // additional
  Color textColor = Colors.white,
  double height = 40.0,
  //BorderRadius radius = BorderRadius.zero,
}) =>
    Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 22,
            color: textColor,
          ),
        ),
      ),
    );

Widget defaultFormField({
  @required Function validFun,
  @required String text,
  TextStyle textStyle,
  @required TextInputType keyBoardType, // think it's not required default .text
  @required TextEditingController controller,
  @required IconData prefix, // think it's not required
  IconData suffix, // I did both of these is the same attribute
  Function suffixPressed, // IconButton suffixIcon
  EdgeInsets padding,
  Function onSubmit,
  Function onChange,
  Function onTap,
  FocusNode focus,
  bool isClickable = true,
  bool isPassword = false,
  bool onlyRead = false,
}) =>
    TextFormField(
      readOnly: onlyRead,
      //showCursor: onlyRead,
      focusNode: focus,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyBoardType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validFun,
      enabled: isClickable,
      decoration: InputDecoration(
        contentPadding: padding,
        labelText: text,
        labelStyle: textStyle,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null // not sure if the test is necessary
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 40,
                child: Text(
                  "${model["time"]}",
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
              // I added this widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model["title"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model["date"]}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'done', id: model['id']);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'archive', id: model['id']);
              },
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDatabase(id: model['id'],);
      },
    );


Widget taskBuilder({
  @required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => buildOurDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

Widget buildOurDivider() => Container(
  margin: EdgeInsets.only(left: 20),
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);


Widget articleBuilder(list, contextGlobal, {isSearch = false}) => ConditionalBuilder(
  condition: list.length>0, //state is! NewsGetScienceLoadingState,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) =>  buildArticleItem(list[index], contextGlobal),// TODO notice which context!
    separatorBuilder: (context, index) =>  buildOurDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch
      ?Center(child: Text("Nothing"),)
      :Center(child: CircularProgressIndicator()),
);

// the one above use this below:
Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        /*

        ProgressiveImage.custom(

                placeholderBuilder: (BuildContext context) => _customWidget,

                thumbnail: NetworkImage('https://i.imgur.com/4WRfwXm.jpg'), // 64x43

                image: NetworkImage('https://i.imgur.com/0NnZINx.jpg'), // 3240x2160

                height: 250,

                width: 500,

                fit: BoxFit.cover,

              )

         */

        Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              onError: (object, stackTrace) => Center(),

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

          // child: FadeInImage(

          //   fit: BoxFit.cover,

          //   //placeholderErrorBuilder: (context,exception,stackTrace) => Center(child: Text('kachm sraaaa'),),

          //   placeholder: AssetImage('assets/images/maled.png'),

          //   image: NetworkImage('${article['urlToImage']}'),

          //   imageErrorBuilder: (ctx, exception, stackTrace) {

          //     return Center(child: Text('image not found'),); //THE WIDGET YOU WANT TO SHOW IF URL NOT RETURN IMAGE

          //   },

          // ),

          // child: FadeInImage.memoryNetwork(

          //   imageErrorBuilder: (ctx, exception, stackTrace) {

          //     return Center(child: Text('image not found'),); //THE WIDGET YOU WANT TO SHOW IF URL NOT RETURN IMAGE

          //   },

          //   placeholder: kTransparentImage,//'assets/images/male.png',

          //   image: '${article['urlToImage']}',

          //   fit: BoxFit.cover,

          // ),

        ),

        SizedBox(width: 20.0,),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              //mainAxisSize: MainAxisSize.min,

              //mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: Theme.of(context).textTheme.bodyText2,

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);