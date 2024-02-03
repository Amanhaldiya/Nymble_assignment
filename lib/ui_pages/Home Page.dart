import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/apis_calls/classfetch.dart';
import 'package:myapp/state_mangement/provider.dart';
import 'package:myapp/ui_pages/Details%20Page.dart';
import 'package:myapp/ui_pages/History%20Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late List<Pet> pets;
  late List<Pet> adoptedPets;
  bool isDarkMode = false; 

  //Method to toggle themes
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
  TextEditingController searchController = TextEditingController();

  @override
  void initState() 
  {
    super.initState();
    pets = [];
    fetchPets();
    adoptedPets = [];
  }

  Future<void> fetchPets() async 
  {
    final jsonString = await rootBundle.loadString('lib/apis_calls/data.json');
    final List<dynamic> data = jsonDecode(jsonString);
    setState(() {
      pets = data.map((pet) => Pet.fromJson(pet)).toList();
    });
  }

  void _adoptPet(Pet pet) 
  {
    setState(() {
      pet.adopted = true;
      adoptedPets.add(pet);
    });
    showAdoptionSnackBar(pet.name);
  }

  void showAdoptionSnackBar(String petName) 
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You adopted $petName'),
      ),
    );
  }

  List<Pet> get filteredPets
   {
    final searchQuery = searchController.text.toLowerCase();
    return pets.where((pet) => pet.name.toLowerCase().contains(searchQuery)).toList();
  }


   
  @override
  Widget build(BuildContext context) 
  {
    final themeProvider = context.watch<ThemeNotifier>();

    return Scaffold
       (
        appBar: AppBar
        (
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.blue,
        title: const Text('My App'),
        actions: [
          IconButton
          (
            onPressed: ()
             {
              themeProvider.toggleTheme();
            },
            icon: const Icon(Icons.lightbulb),
           ),
        
      

          IconButton(
             onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => HistoryPage(adoptedPets),
                  ),
                  );
              },
                icon: const Icon(Icons.history),
              ),
        ],
      ),
          
        body: GestureDetector(
            onTap: () 
            {
              FocusScope.of(context).unfocus();
            },
            child: Column
            (
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField
                  (
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by name...',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),

                const Divider(),

                Expanded(
                  child: ListView.separated
                  (
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredPets.length,
                    itemBuilder: (context, index) 
                    {
                      return Column
                      (
                        children: [
                          ListTile
                          (
                            leading: Hero(
                              tag: 'petImage${filteredPets[index].name}',
                              child: CircleAvatar
                              (
                                backgroundImage: NetworkImage(filteredPets[index].image),
                              ),
                            ),
                            title: Text
                            (
                              filteredPets[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: filteredPets[index].adopted ? Colors.grey : const Color.fromARGB(206, 2, 74, 133),
                              ),
                            ),

                            trailing: ElevatedButton
                            (
                              onPressed: ()
                               {
                                if (!filteredPets[index].adopted) 
                                {
                                  setState(() {
                                    filteredPets[index].adopted = true;
                                  }
                                  );
                                  _adoptPet(filteredPets[index]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('You adopted ${filteredPets[index].name}'),
                                    ),
                                  );
                                }
                              },

                              child: Text(filteredPets[index].adopted ? '✔ Check' : 'Adopt Me'),
                            ),
                            subtitle: Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text
                                (
                                  'Age: ${filteredPets[index].age}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text
                                (
                                  'Price: \$${filteredPets[index].price}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onTap: () 
                            {
                              if (!filteredPets[index].adopted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetDetails(
                                      pet: filteredPets[index],
                                      onAdopt: () => _adoptPet(filteredPets[index]),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          // Divider between each list item
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
              ],
            ),
          ),
        
    );
    }
  
}


