class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}
