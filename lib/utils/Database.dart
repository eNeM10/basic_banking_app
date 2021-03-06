import 'dart:io';
import 'dart:math';

import 'package:basic_banking_app/constants/data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

import 'package:basic_banking_app/models/CustomerModel.dart';
import 'package:basic_banking_app/models/TransactionModel.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  var uuid = Uuid();

  Random random = new Random();

  List<String> randomPhoneNumbers = [
    "(501) 429-6714",
    "(260) 482-5261",
    "(581) 278-8547",
    "(573) 535-1143",
    "(604) 700-7304",
    "(790) 727-2827",
    "(896) 761-6211",
    "(752) 450-0377",
    "(534) 341-8407",
    "(203) 449-1509",
  ];

  List<String> customerIDs = [
    'liomessi',
    'davidbeckham',
    'cristiano',
    'neymarjr',
    'iamzlatanibrahimovic',
    'alexmorgan13',
    'c_sinc12',
    'mrapinoe',
    'ahegerberg',
    'liekemartens',
  ];
  /*

<a href="https://ibb.co/TBC1580"><img src="https://i.ibb.co/xS4YQjg/Ada-Hegerberg.jpg" alt="Ada-Hegerberg" border="0"></a>
<a href="https://imgbb.com/"><img src="https://i.ibb.co/nzBRZHd/Alex-Morgan.jpg" alt="Alex-Morgan" border="0"></a>
<a href="https://ibb.co/WD2nN72"><img src="https://i.ibb.co/pWL26NL/Christine-Sinclair.jpg" alt="Christine-Sinclair" border="0"></a>
<a href="https://ibb.co/sJ3TY4m"><img src="https://i.ibb.co/1J2CWNv/Cristiano-Ronaldo.jpg" alt="Cristiano-Ronaldo" border="0"></a>
<a href="https://ibb.co/GRVCVJP"><img src="https://i.ibb.co/XtzFz4J/David-Beckham.jpg" alt="David-Beckham" border="0"></a>
<a href="https://ibb.co/7ymTKRs"><img src="https://i.ibb.co/mzWY4Xf/Lieke-Martens.jpg" alt="Lieke-Martens" border="0"></a>
<a href="https://imgbb.com/"><img src="https://i.ibb.co/Wg4fjfx/Lionel-Messi.jpg" alt="Lionel-Messi" border="0"></a>
<a href="https://ibb.co/Pt1mnGS"><img src="https://i.ibb.co/HXGFsTJ/Megan-Rapione.jpg" alt="Megan-Rapione" border="0"></a>
<a href="https://ibb.co/0nQ4Npf"><img src="https://i.ibb.co/FhnZvkB/NeymarJr.jpg" alt="NeymarJr" border="0"></a>
<a href="https://imgbb.com/"><img src="https://i.ibb.co/pdgtVmb/Zlatan-Ibrahimovic.jpg" alt="Zlatan-Ibrahimovic" border="0"></a><br /><a target='_blank' href='https://imgbb.com/'>picture upload site</a><br />


  */

  List<String> userProfileImages = [
    'https://i.ibb.co/Wg4fjfx/Lionel-Messi.jpg',
    'https://i.ibb.co/XtzFz4J/David-Beckham.jpg',
    'https://i.ibb.co/1J2CWNv/Cristiano-Ronaldo.jpg',
    'https://i.ibb.co/FhnZvkB/NeymarJr.jpg',
    'https://i.ibb.co/pdgtVmb/Zlatan-Ibrahimovic.jpg',
    'https://i.ibb.co/nzBRZHd/Alex-Morgan.jpg',
    'https://i.ibb.co/pWL26NL/Christine-Sinclair.jpg',
    'https://i.ibb.co/HXGFsTJ/Megan-Rapione.jpg',
    'https://i.ibb.co/xS4YQjg/Ada-Hegerberg.jpg',
    'https://i.ibb.co/mzWY4Xf/Lieke-Martens.jpg',
  ];

  List list = List.generate(10, (i) => i);

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'customers.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers(
        designation TEXT,
        firstname TEXT,
        lastname TEXT,
        id TEXT,
        balance DOUBLE,
        phone STRING,
        dpurl STRING
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        txid TEXT,
        fromid TEXT,
        toid TEXT,
        amount NUMBER,
        date TEXT
      )
    ''');

    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mr.',
      'Lionel',
      'Messi',
      'liomessi',
      3050000,
      randomPhoneNumbers[0],
      userProfileImages[0],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mr.',
      'David',
      'Beckham',
      'davidbeckham',
      2500000,
      randomPhoneNumbers[1],
      userProfileImages[1],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mr.',
      'Cristiano',
      'Ronaldo',
      'cristiano',
      4050000,
      randomPhoneNumbers[2],
      userProfileImages[2],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mr.',
      'Neymar',
      'Jr.',
      'neymarjr',
      2050000,
      randomPhoneNumbers[3],
      userProfileImages[3],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mr.',
      'Zlatan',
      'Ibrahimovic',
      'iamzlatanibrahimovic',
      1850000,
      randomPhoneNumbers[4],
      userProfileImages[4],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mrs.',
      'Alex',
      'Morgan',
      'alexmorgan13',
      1550000,
      randomPhoneNumbers[5],
      userProfileImages[5],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Ms.',
      'Christine',
      'Sinclair',
      'c_sinc12',
      1950000,
      randomPhoneNumbers[6],
      userProfileImages[6],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mrs.',
      'Megan ',
      'Rapinoe',
      'mrapinoe',
      2550000,
      randomPhoneNumbers[7],
      userProfileImages[7],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Mrs.',
      'Ada',
      'Hegerberg',
      'ahegerberg',
      1850000,
      randomPhoneNumbers[8],
      userProfileImages[8],
    ]);
    await db.rawInsert('INSERT INTO customers VALUES(?, ?, ?, ?, ?, ?, ?)', [
      'Ms.',
      'Lieke',
      'Martens',
      'liekemartens',
      3570000,
      randomPhoneNumbers[9],
      userProfileImages[9],
    ]);

    await populateTransactionsTable(db, 100);
    print('database created');
  }

  Future<int> populateTransactionsTable(Database db, numberOfTx) async {
    for (int i = 0; i < numberOfTx; i++) {
      createTx(db);
    }
    return 0;
  }

  Future<int> createTx(Database db) async {
    list.shuffle();
    var today = DateTime.now();
    var dayDiff = random.nextInt(7 * 30);
    var hourDiff = random.nextInt(24);
    var minDiff = random.nextInt(60);
    var randDate = today
        .subtract(Duration(days: dayDiff, hours: hourDiff, minutes: minDiff));

    double randAmount = double.parse(
        (random.nextInt(10000) + 1000 + random.nextDouble())
            .toStringAsFixed(2));

    TransactionModel tx = TransactionModel(
      txId: uuid.v4(),
      toId: customerIDs[list[0]],
      fromId: customerIDs[list[1]],
      amount: randAmount,
      date: randDate,
    );

    return await db.insert('transactions', tx.toJson());
  }

  Future<int> makeTransaction(TransactionModel tx) async {
    Database db = await instance.database;
    return await db.insert('transactions', tx.toJson());
  }

  Future<List<CustomerInfo>> getAllCustomers() async {
    Database db = await instance.database;
    var customers = await db.query('customers', orderBy: 'lastname');
    List<CustomerInfo> customerList = customers.isNotEmpty
        ? customers.map((c) => CustomerInfo.fromJson(c)).toList()
        : [];
    return customerList;
  }

  Future<List<CustomerInfo>> getCustomers(user) async {
    Database db = await instance.database;
    var customers = await db.query('customers',
        orderBy: 'lastname', where: 'id != ?', whereArgs: ['$user']);
    List<CustomerInfo> customerList = customers.isNotEmpty
        ? customers.map((c) => CustomerInfo.fromJson(c)).toList()
        : [];
    return customerList;
  }

  Future<CustomerInfo> getCustomerFromID(id) async {
    Database db = await instance.database;
    var customers =
        await db.query('customers', where: 'id = ?', whereArgs: ['$id']);
    List<CustomerInfo> customerList = customers.isNotEmpty
        ? customers.map((c) => CustomerInfo.fromJson(c)).toList()
        : [];
    return customerList[0];
  }

  Future<String> getCustomerFirstName(id) async {
    Database db = await instance.database;
    var customers =
        await db.query('customers', where: 'id = ?', whereArgs: ['$id']);
    List<CustomerInfo> customerList = customers.isNotEmpty
        ? customers.map((c) => CustomerInfo.fromJson(c)).toList()
        : [];
    return customerList[0].firstname;
  }

  Future<String> getCustomerPhotoURL(id) async {
    Database db = await instance.database;
    var customers =
        await db.query('customers', where: 'id = ?', whereArgs: ['$id']);
    List<CustomerInfo> customerList = customers.isNotEmpty
        ? customers.map((c) => CustomerInfo.fromJson(c)).toList()
        : [];
    return customerList[0].dpurl;
  }

  Future<int> add(CustomerInfo customerInfo) async {
    Database db = await instance.database;
    return await db.insert('customers', customerInfo.toJson());
  }

  Future<int> updateBalance(id, balance) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        'UPDATE customers SET balance = ? WHERE id = ?', [balance, id]);
  }

  // Future<int> remove(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  // }

  Future<int> addTx(TransactionModel tx) async {
    Database db = await instance.database;
    return await db.insert('transactions', tx.toJson());
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    Database db = await instance.database;
    var transactions = await db.query('transactions', orderBy: 'date');
    List<TransactionModel> transactionList = transactions.isNotEmpty
        ? transactions.map((c) => TransactionModel.fromJson(c)).toList()
        : [];
    return transactionList;
  }

  Future<List<TransactionModel>> getTransactions(user) async {
    Database db = await instance.database;
    var transactions = await db.query(
      'transactions',
      orderBy: 'date DESC',
      where: 'fromid = ? OR toid = ?',
      whereArgs: [user, user],
    );
    List<TransactionModel> transactionList = transactions.isNotEmpty
        ? transactions.map((c) => TransactionModel.fromJson(c)).toList()
        : [];
    return transactionList;
  }

  Future<List<TransactionModel>> getTransactionsBetweenUsers(
      String user) async {
    Database db = await instance.database;
    var transactions = await db.query(
      'transactions',
      orderBy: 'date DESC',
      where: '(fromid = ? AND toid = ?) OR (fromid = ? AND toid = ?)',
      whereArgs: [user, username, username, user],
    );
    List<TransactionModel> transactionList = transactions.isNotEmpty
        ? transactions.map((c) => TransactionModel.fromJson(c)).toList()
        : [];
    return transactionList;
  }

  // Future<int> removeTx(int txId) async {
  //   Database db = await instance.database;
  //   return await db.delete('transactions', where: 'txid = ?', whereArgs: [txId]);
  // }

  Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'customers.db');
    databaseFactory.deleteDatabase(path);
  }
}
