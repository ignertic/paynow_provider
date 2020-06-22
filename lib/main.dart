import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/checkout.dart';
import 'providers/cart.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
MyHomePage({Key key,}) : super(key: key);

@override
Widget build(BuildContext context) {
  return
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context)=>Cart('Customer 3', 'paynow@gisho.co.zw'),
      )
    ],

    child: MaterialApp(
     title: 'BITSA',
     theme: ThemeData(

     ),
     routes: {
       '/' :(context)=> _MyHomePage(),
       '/checkout': (context)=>CheckoutPage()
     },
     initialRoute: '/',
     darkTheme: ThemeData.dark(),

     debugShowCheckedModeBanner: false,
   )
  );
}
}

class _MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed:(){
          // Navigate to cart page
          Navigator.pushNamed(context, '/checkout');
        } ,
      ),
      appBar: AppBar(
        title: Text('Total - ${cart.total()}'),
        actions: <Widget>[
        Icon(Icons.shopping_cart),
        Text('${cart.items.length}')
      ],),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder:(context, index){
          return ListTile(
            title: Text('Item $index') ,
            trailing: IconButton(
              icon: cart.isInCart('Item $index') ?Icon(Icons.check_circle) : Icon(Icons.shopping_cart),
              onPressed: (){
                print(cart.isInCart('Item $index'));
                if (cart.isInCart('Item $index')){

                } else{
                  cart.addToCart('Item $index', 2.00);
                }
              },
            ),
          );
        } ,
      ),
    );
  }

}
