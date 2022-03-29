

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_application/modules/webView/webView.dart';
import 'package:news_application/shared/cubit/cubit.dart';


Widget deafultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validator,
  Function ? OnChange,
  Function? onSubmit,
  OnTap,
  IconData ? prefix,
  String ? label,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  validator: (String ? value){
    return validator(value);
  },
  decoration: InputDecoration(
      prefixIcon: Icon(
          prefix
      ),
      labelText: label,
      border: OutlineInputBorder()
  ),
  onTap: OnTap,
  onChanged:( value)
  {
    return OnChange!(value);
  },
  onFieldSubmitted: (String value){
    return onSubmit!(value);
  },

);
//var refreshKey = GlobalKey<RefreshIndicatorState>();

Widget buildArticleItem(article,context) => GestureDetector(
  onTap: ()
  {
    NavigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15.0),

            image: DecorationImage(

             image: NetworkImage('${article['urlToImage'] == null ?
             'https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png'
                 : article['urlToImage'] }'),
              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(width:10.0,),

        Expanded(

          child: Container(

            //height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  '${article['title']}' ,

                  style: Theme.of(context).textTheme.bodyText1,

                  maxLines: 4,

                  overflow: TextOverflow.ellipsis,

                )  ,

                Text(

                  '${article['publishedAt']}',

                  style: Theme.of(context).textTheme.bodyText1

                ),

              ],

            ),



          ),

        )

      ],

    ),

  ),
);

Widget articleBuilder (list,context,{isSearch=false})=> Conditional.single(
    context: context,
    conditionBuilder: (context)=>list.length > 0,
    widgetBuilder: (context)=>ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildArticleItem(NewsAppCubit.get(context).search[index],context),
        separatorBuilder:(context,index)=> myDivider(),
        itemCount: list.length
    ),
    fallbackBuilder: (context)=>isSearch ? Container(): Center(child: CircularProgressIndicator())
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
    height: 1.0,
    color: Colors.grey,
  ),
);

void NavigateTo(context,widget) => Navigator.push(context,
    MaterialPageRoute(
    builder: (context)=> widget
    ));