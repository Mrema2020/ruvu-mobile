import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  final List<String> rules = [
    'Do not dispose of any waste or garbage in the river. Use designated trash cans or recycling bins on the riverbank.',
    'It is not allowed to use the river as a toilet. Use public restrooms or portable toilets located nearby.',
    'Do not use soaps or shampoos in the river. Use biodegradable soaps and shampoos on land.',
    'It is highly prohibited t use the river for industrial or commercial purposes without proper permits and regulations.',
    'Do not use pesticides, herbicides, or fertilizers near the river. These chemicals can leach into the water and harm aquatic life.',
    'Do not disturb or damage the riverbank or surrounding vegetation. These areas are important habitats for wildlife.',
    'Do not release exotic or non-native species into the river. These can disrupt the natural balance of the ecosystem.',
    'Do not use motorized watercraft or other vehicles that can pollute the river with exhaust fumes or oil leaks.',
    'Do not disturb or remove any natural resources from the river, such as rocks, sand, or gravel.',
    'Do not create erosion or sedimentation in the river. These can cause damage to the riverbed and banks, and harm aquatic life.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rules'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: rules.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.warning,
            color: Colors.orangeAccent,
            ),
            title: Text(rules[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
