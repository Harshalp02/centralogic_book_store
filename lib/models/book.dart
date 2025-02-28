class Book {
  final String title;
  final String price;
  final String image;
  final int quantity; // Added quantity field

  Book({
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1, // Default quantity is 1
  });

  // ✅ Add copyWith method for updating book properties
  Book copyWith({String? title, String? price, String? image, int? quantity}) {
    return Book(
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  // ✅ Factory method to create a Book from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      price: json['price'],
      image: json['image'],
      quantity: json['quantity'] ?? 1, // Ensure quantity is set from JSON
    );
  }

  // ✅ Convert Book to JSON (useful for storing cart data)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
