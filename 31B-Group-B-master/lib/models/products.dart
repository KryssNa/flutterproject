class Product{
  final String name;
  final String image;
  final double rating;
  final double price;
  final String vendor;
  final bool whishList;
  int quantity;
  double pricePerItem;

  Product({required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.vendor,
    required this.whishList,
    required this.pricePerItem
  });


}