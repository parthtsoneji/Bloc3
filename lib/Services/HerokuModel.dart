class HerokuPizza {
  int? count;
  List<Recipes>? recipes;

  HerokuPizza({this.count, this.recipes});

  HerokuPizza.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipes {
  String? publisher;
  String? title;
  String? sourceUrl;
  String? recipeId;
  String? imageUrl;
  double? socialRank;
  String? publisherUrl;

  Recipes(
      {this.publisher,
        this.title,
        this.sourceUrl,
        this.recipeId,
        this.imageUrl,
        this.socialRank,
        this.publisherUrl});

  Recipes.fromJson(Map<String, dynamic> json) {
    publisher = json['publisher'];
    title = json['title'];
    sourceUrl = json['source_url'];
    recipeId = json['recipe_id'];
    imageUrl = json['image_url'];
    socialRank = json['social_rank'];
    publisherUrl = json['publisher_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publisher'] = this.publisher;
    data['title'] = this.title;
    data['source_url'] = this.sourceUrl;
    data['recipe_id'] = this.recipeId;
    data['image_url'] = this.imageUrl;
    data['social_rank'] = this.socialRank;
    data['publisher_url'] = this.publisherUrl;
    return data;
  }
}