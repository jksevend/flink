import 'package:easy_localization/easy_localization.dart';
import 'package:flink/page/settings_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flink'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SettingsPage())),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'tooltip_create_todo'.tr(),
        child: const Icon(Icons.add_task_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.task_outlined),
              tooltip: 'tooltip_todo_overview'.tr(),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.collections_bookmark_outlined),
              tooltip: 'tooltip_collection_overview'.tr(),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline_outlined),
              tooltip: 'tooltip_favourites'.tr(),
            )
          ],
        ),
      ),
    );
  }
}
