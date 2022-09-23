class Category {
  static String sportsId = 'sports';
  static String musicId = 'music';
  static String moviesId = 'movies';

  String id;
  late String name;
  late String image;

  Category(this.id, this.name, this.image);

  Category.formId(this.id) {
    image = 'assets/images/$id.jpeg';
    name = id;
  }

  static List<Category> getCategory() {
    return [
      Category.formId(sportsId),
      Category.formId(musicId),
      Category.formId(moviesId),
    ];
  }
}
