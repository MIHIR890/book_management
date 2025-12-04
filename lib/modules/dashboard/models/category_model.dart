class Category {
  final String id;
  final int categoryId;
  final String name;

  Category({required this.id, required this.categoryId, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      categoryId: json['id'],
      name: json['name'],
    );
  }
}
