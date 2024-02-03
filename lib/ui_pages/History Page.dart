
import 'package:flutter/material.dart';
import 'package:myapp/apis_calls/classfetch.dart';


class HistoryPage extends StatelessWidget {
  final List<Pet> adoptedPets;

  HistoryPage(this.adoptedPets, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Adoption History'),
        centerTitle: true,
      ),
      body: ListView.builder
      (
        itemCount: adoptedPets.length,
        itemBuilder: (context, index) 
        {
          return ListTile(
             leading: CircleAvatar
             (
                      backgroundImage: NetworkImage(adoptedPets[index].image),
            ),
            title: Text(adoptedPets[index].name),
            subtitle: Text('Adopted on ${DateTime.now()}'),
          );
        },
      ),
    );
  }
}