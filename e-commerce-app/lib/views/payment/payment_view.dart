// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/core/const/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/const/border/border_radi.dart';
import '../../product/constant/warning_message.dart';

class PaymentPageView extends StatefulWidget {
  double totalFee = 0.0;
  PaymentPageView({
    Key? key,
    required this.totalFee,
  }) : super(key: key);
  @override
  State<PaymentPageView> createState() => _PaymentPageViewState();
}

class _PaymentPageViewState extends State<PaymentPageView> {
  final String paymentCompletedSuccessfully = 'Payment completed successfully';
  final String completePayment = 'Complete Payment';
  final String cardNumber = 'Card number';
  final String cardInformation = 'Card information';
  final String mmyy = 'MM/YY';
  final String cvc = 'CVC';
  TextEditingController cardController = TextEditingController();
  TextEditingController cvcContoller = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: context.midAllPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: buildTitleText(context),
              ),
              SizedBox(
                height: context.dynamicHeight(0.1),
              ),
              buildCardInfoText(context),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              buildCardNumberTextformField(),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              buildDateTextformField(),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              buildCvcTextformField(),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              buildButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Text buildTitleText(BuildContext context) {
    return Text(
      " Total Price:  ${widget.totalFee.toString()} €  ",
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Text buildCardInfoText(BuildContext context) {
    return Text(
      "${cardInformation}",
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  TextFormField buildCardNumberTextformField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 16,
      // validator: (value) =>
      //     (value ?? "").length > 10 ? null : "11'den kucuk",
      controller: cardController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "${cardNumber}"),
    );
  }

  TextFormField buildDateTextformField() {
    return TextFormField(
      maxLength: 5,
      keyboardType: TextInputType.datetime,
      // validator: (value) =>
      //     (value ?? "").length > 3 ? null : "",
      controller: dateController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "${mmyy} "),
    );
  }

  TextFormField buildCvcTextformField() {
    return TextFormField(
      maxLength: 3,
      keyboardType: TextInputType.number,
      // validator: (value) =>
      //     (value ?? "").length > 3 ? null : "",
      controller: cvcContoller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          labelText: "${cvc}"),
    );
  }

  Center buildButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          warningToast(context, "${paymentCompletedSuccessfully}");
        },
        child: Container(
          padding: context.minAllPadding,
          decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadi.midCircular),
          height: context.dynamicHeight(0.08),
          width: context.dynamicWidth(0.6),
          child: Center(
            child: Text(
              "${completePayment}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
