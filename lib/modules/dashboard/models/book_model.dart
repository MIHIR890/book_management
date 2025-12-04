class BookModel {
  final String bookId;
  final int categoryId;
  final String bookName;
  final String authorName;

  BookModel(
      {required this.bookId,
        required this.categoryId,
        required this.bookName,
        required this.authorName});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      bookId: json['bookId'],
      categoryId: json['categoryId'],
      bookName: json['bookName'],
      authorName: json['authorName'],
    );
  }
}
