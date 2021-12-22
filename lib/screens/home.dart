import 'package:flutter/material.dart';
import 'package:restoran/screens/reservation.dart';
import 'package:restoran/widgets/products_view.dart';

import '../presentation/custom_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  late TabController _tabController;
  late int _initialCategoryId = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      setState(() {
        _initialCategoryId = _tabController.index + 1;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.emoji_food_beverage), text: "İçecekler"),
            Tab(icon: Icon(Icons.dinner_dining), text: "Yiyecekler"),
            Tab(icon: Icon(Icons.cake), text: "Tatlılar"),
            Tab(icon: Icon(CustomIcon.hookah), text: "Nargile"),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
          child: ProductsView(categoryId: _initialCategoryId)),
      floatingActionButton: FloatingActionButton(
        tooltip: "Reservasyon oluştur",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const ReservationScreen();
              },
            ),
          );
        },
        child: const Icon(
          Icons.brunch_dining,
        ),
        heroTag: Object(),
      ),
    );
  }
}
