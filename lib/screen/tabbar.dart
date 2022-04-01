import 'package:flutter/material.dart';

class Tab extends StatefulWidget {
  const Tab({Key? key}) : super(key: key);

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab> with TickerProviderStateMixin {
  // TabController _tabController = TabController(length: 2, vsync: this)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: const TabBar(
                tabs: [
                  // Tab(Text:"admin"),
                  // Tab(text:"admin"),
                ]

            ),




          ),
          Container(
            child: const TabBarView(
              children: [
                Text("hi"),
                Text("hi")
              ],
            ),
          )
        ],
      ),

    );
  }
}
