import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/constants/data.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/screens/ProfilePopScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/utils/TimeFormatter.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TransactionPopScreen extends StatefulWidget {
  const TransactionPopScreen({required this.transaction, Key? key})
      : super(key: key);
  final TransactionModel transaction;
  @override
  _TransactionPopScreenState createState() => _TransactionPopScreenState();
}

class _TransactionPopScreenState extends State<TransactionPopScreen> {
  @override
  Widget build(BuildContext context) {
    TransactionModel transaction = widget.transaction;
    CustomerInfo? userInfo;
    late bool isExpense;
    late String user;
    String amountInt = widget.transaction.amount.toInt().toString();
    String amountDec =
        ((widget.transaction.amount * 100) - (int.parse(amountInt) * 100))
            .toInt()
            .toString();
    if (transaction.fromId == username) {
      user = transaction.toId;
      isExpense = true;
    } else {
      user = transaction.fromId;
      isExpense = false;
    }
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              minWidth: 5,
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(LineIcons.share),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              minWidth: 5,
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(LineIcons.verticalEllipsis),
            ),
          ),
        ],
      ),
      body: FutureBuilder<CustomerInfo>(
        future: DatabaseHelper.instance.getCustomerFromID(user),
        builder: (
          BuildContext context,
          AsyncSnapshot<CustomerInfo> snapshot,
        ) {
          if (snapshot.data == null) {
            return Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 60.0,
                color: kDarkTextColorB,
                milliseconds: 200,
                numberOfDots: 5,
              ),
            );
          } else {
            userInfo = snapshot.data;
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfilePopScreen(
                                  username: userInfo!.id,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            LineIcons.user,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            isExpense ? 'To: ' : 'From: ',
                            style: TextStyle(
                              color: kDarkTextColor2,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${userInfo!.designation} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${userInfo!.firstname} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '${userInfo!.lastname}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        userInfo!.phone,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getTransactionTimeDetailed(transaction.date),
                        style: TextStyle(
                          color: kDarkTextColor2,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$currencySymbol ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        '$amountInt',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 56,
                        ),
                      ),
                      Text(
                        '.$amountDec',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(width: 2, color: Colors.white54)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction ID: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${transaction.txId}',
                              style: TextStyle(
                                fontSize: 16,
                                color: kDarkTextColor2,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  isExpense ? 'To: ' : 'From: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${userInfo!.designation} ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${userInfo!.firstname} ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${userInfo!.lastname}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${userInfo!.id}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  isExpense ? 'From: ' : 'To: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Mr. ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'David ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Beckham',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$username',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
