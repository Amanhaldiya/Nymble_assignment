class Pet {
  final String name;
  final int age;
  final int price;
  final String image;
  bool adopted;

  Pet({
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    this.adopted = false,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      age: json['age'],
      price: json['price'],
      image: json['image'],
      adopted: json['adopted'] ?? false,
    );
  }
}

