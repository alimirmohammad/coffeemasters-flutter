import 'package:coffee_masters/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:coffee_masters/pages/menu_page.dart';
import 'package:coffee_masters/pages/orders_page.dart';
import 'package:coffee_masters/pages/offers_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  var dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    Widget currentPageWidget;

    switch (selectedIndex) {
      case 0:
        currentPageWidget = MenuPage(
          dataManager: dataManager,
        );
        break;
      case 1:
        currentPageWidget = const OffersPage();
        break;
      case 2:
        currentPageWidget = OrdersPage(
          dataManager: dataManager,
        );
        break;
      default:
        currentPageWidget = MenuPage(
          dataManager: dataManager,
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo.png"),
      ),
      body: currentPageWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          selectedIndex = value;
        }),
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade100,
        items: const [
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(Icons.coffee),
          ),
          BottomNavigationBarItem(
            label: "Offers",
            icon: Icon(Icons.local_offer),
          ),
          BottomNavigationBarItem(
            label: "Orders",
            icon: Icon(Icons.shopping_cart_checkout_outlined),
          ),
        ],
      ),
    );
  }
}
