
import 'package:flutter/material.dart';
import 'package:myapp/apis_calls/classfetch.dart';

import 'package:myapp/ui_pages/zoomable.dart';

class PetDetails extends StatefulWidget {
  final Pet pet;
  final VoidCallback onAdopt;

  const PetDetails({Key? key, required this.pet, required this.onAdopt}) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}
class _PetDetailsState extends State<PetDetails> {
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(widget.pet.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView
      (
        child: Center
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            children: 
            [
              GestureDetector(
                onTap: () 
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZoomableImagePage(imageUrl: widget.pet.image),
                    ),
                  );
                },
                child: Hero(
                  tag: 'petImage${widget.pet.name}',
                  child: Image.network(widget.pet.image, height: 300, width: 400),
                ),
              ),

              const SizedBox(height: 20),

              Text('Age: ${widget.pet.age}', style: const TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),

              Text('Price: \$${widget.pet.price}', style: const TextStyle(fontWeight: FontWeight.bold)),

               const SizedBox(height: 250),
               
              ElevatedButton(
                onPressed: () {
                  if (!widget.pet.adopted) {
                    widget.onAdopt();
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.pet.adopted ? 'Already Adopted' : 'Adopt Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}