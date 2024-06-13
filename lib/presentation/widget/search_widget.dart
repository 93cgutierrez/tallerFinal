import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchOverlay extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  SearchOverlay({super.key, required TextEditingController controller});

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: 'Buscar...',
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: (text) {
          // Realizar la búsqueda con el texto ingresado
          if (kDebugMode) {
            print('Búsqueda: $text');
          }
          // Ocultar el campo de búsqueda
          setState(() {});
        },
      ),
    );
  }
}
