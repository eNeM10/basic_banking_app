import 'package:basic_banking_app/constants/colors.dart';
import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';
import 'package:basic_banking_app/screens/secondary_screens/GetHelpScreen.dart';
import 'package:basic_banking_app/screens/secondary_screens/MakePaymentScreen.dart';
import 'package:basic_banking_app/screens/secondary_screens/SendFeedbackScreen.dart';
import 'package:basic_banking_app/utils/Database.dart';
import 'package:basic_banking_app/widgets/transactionCard.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ProfilePopScreen extends StatefulWidget {
  const ProfilePopScreen({required this.user, Key? key}) : super(key: key);
  final CustomerInfo user;
  @override
  _ProfilePopScreenState createState() => _ProfilePopScreenState();
}

class _ProfilePopScreenState extends State<ProfilePopScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    CustomerInfo user = widget.user;
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kDarkTextColorB,
        ),
        elevation: 4,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<String>(
            color: Color(0xFF212024),
            elevation: 16,
            onSelected: (String value) {
              switch (value) {
                case 'Report':
                  //Report the person (:
                  break;
                case 'Block':
                  //Block the person (:
                  break;
                case 'Get Help':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GetHelpScreen(),
                    ),
                  );
                  break;
                case 'Send Feedback':
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendFeedbackScreen(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Report',
                'Block',
                'Get Help',
                'Send Feedback',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LineIcons.user,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${user.designation} ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          '${user.firstname} ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                        Text(
                          '${user.lastname}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.phone,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.id}',
                                style: TextStyle(
                                  color: kDarkTextColor2,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Previous Transactions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              minWidth: 5,
                              shape: CircleBorder(),
                              onPressed: () {},
                              child: Icon(
                                LineIcons.syncIcon,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kDarkTextColor2,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 4.0,
                        right: 4.0,
                      ),
                      child: SizedBox(
                        height: height * 0.4,
                        child: FutureBuilder<List<TransactionModel>>(
                          future: DatabaseHelper.instance
                              .getTransactionsBetweenUsers(user.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<TransactionModel>> snapshot) {
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
                              if (snapshot.data!.length < 1) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'No Previous Transactions',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: kDarkTextColor2, fontSize: 35),
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (index == snapshot.data!.length) {
                                      return SizedBox(
                                        height: 60,
                                      );
                                    }
                                    return TransactionCardWidget(
                                      transaction: snapshot.data![index],
                                      compact: true,
                                    );
                                  },
                                  itemCount: snapshot.data!.length + 1,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MakePaymentScreen(user: user),
                              ),
                            );
                          },
                          color: kDarkTextColorB,
                          elevation: 6,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.arrowUp,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Send Money  '),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            //TODO: Implement Request Money
                          },
                          color: kDarkTextColorB,
                          elevation: 6,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.arrowDown,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Request Money  '),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
