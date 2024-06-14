import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/search_widget.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final _searchController = TextEditingController();
  bool _showSearchOverlay = false;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text('Mi aplicación'),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {});
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          setState(() {
            _searchController.text = text;
          });
        },
        // onSubmitted: (text) {
        //   searchText.value = text;
        // },
        animation: AppBarAnimationSlideLeft.call,
        // animation: (child) => AppBarAnimationSlideLeft(
        //     milliseconds: 400, withFade: false, percents: 0.25, child: child),
        appBarBuilder: (context) {
          return AppBar(
            title: const Text("Todo sobre series"),
            actions: const [
              // AppBarSpeechButton(),  // in version 2.0+
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
/*      AppBar(
        title: const Text('Mi aplicación'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showSearchOverlay = !_showSearchOverlay;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),*/
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contenido de la aplicación: ${_searchController.text}'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSearchOverlay = !_showSearchOverlay;
                  });
                },
                child: const Text('Mostrar búsqueda'),
              ),
            ],
          ),
        ),
        // Widget de búsqueda emergente
        Visibility(
          visible: _showSearchOverlay,
          child: SearchOverlay(controller: _searchController),
        ),
      ]),
    );
/*      Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                // Removed filled: true
                labelText: 'Busqueda',
              ),
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );*/
  }
}
