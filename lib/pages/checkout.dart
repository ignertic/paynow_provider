import 'package:flutter/material.dart';
import 'package:paynow_provider/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CheckoutPage extends StatelessWidget{
  String _phoneNumber='';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      endDrawer: Drawer(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed:(){
                    cart.remove(cart.items[index]);
                  } ,
                ),
                title: Text(cart.items[index]['title']),
                trailing: Text(cart.items[index]['amount'].toString()),
              );
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 50),
            child: Text(cart.statusMessage ?? 'Waiting...'),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.lightBlue,
                  child: Text('Express Checkout'),
                  onPressed: (){
                    cart.startExpressCheckout(_phoneNumber, method: 'ecocash');
                  },
                ),
                FlatButton(
                  color: Colors.amber,
                  child: Text('Web Checkout'),
                  onPressed:(){
                    cart.startWebCheckout();
                  } ,
                ),
                FlatButton(
                  color:Colors.greenAccent ,
                  child: Text('Check Status'),
                  onPressed: (){
                    cart.checkTransactionStatus();
                  },
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 80),
            child: TextField(
              onChanged: (value){
                _phoneNumber = value;
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(

                hintText: 'Enter Ecocash Number Here'
              ),
            ),
          )
        ],
      ),
    );
  }

}
