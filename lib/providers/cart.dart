import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class Cart extends ChangeNotifier{

  final String authEmail;
  final String reference;

  final Paynow _paynow = Paynow(
    integrationId: '6054',
    integrationKey: "960ad10a-fc0c-403b-af14-e9520a50fbf4",
    returnUrl: 'https://gisho.co.zw',
    resultUrl: 'https://gisho.co.zw'
  );

  final Payment _payment;
  String statusMessage;
  String _currentPollUrl;

  Cart(this.reference, this.authEmail) :
   this._payment=Payment(reference: reference, authEmail: authEmail);

   get items => this._payment.items;

   get total => this._payment.total;

   isInCart(item){
     // not working

     return this._payment.items.contains({'item' : item, 'amount' : 2.00});
   }


  remove(item){
    this._payment.items.remove(item);
    notifyListeners();
  }

  addToCart(item, price){
    this._payment.add(item, price);
    notifyListeners();
  }

  checkTransactionStatus()async{
    final status = await this._paynow.checkTransactionStatus(_currentPollUrl);
    if (status.paid){
      statusMessage = 'Transaction Complete :)';
      notifyListeners();
    }else{
      statusMessage = 'The transaction failed';
      notifyListeners();
    }
  }


  startExpressCheckout(String phone, {String method='ecocash'})async{
    final response = await this._paynow.sendMobile(_payment, phone, method: method);
    if (response.success){
      _currentPollUrl = response.pollUrl;
      statusMessage='Complete the Transaction on your device';
      notifyListeners();
    }{
      statusMessage='Failed To initiate Transaction';
      notifyListeners();
    }
  }



  startWebCheckout()async{
    final response = await _paynow.send(_payment);

    if (response.success){

      _currentPollUrl=response.pollUrl;

      launch(Uri.decodeFull(response.redirectUrl), forceWebView: true, enableJavaScript: true);
      statusMessage='Transaction Initiated';
      notifyListeners();

    }else{
      statusMessage=response.instructions;
      notifyListeners();
    }

  }

}
