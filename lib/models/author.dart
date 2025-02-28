

class Author {
  final String name;
  final String role;
  final String image;

  Author({required this.name, required this.role, required this.image});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(name: json['name'], role: json['role'], image: json['image']);
  }
}
