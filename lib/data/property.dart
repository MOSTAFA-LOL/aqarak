class Property {
  final String propertyTitle;
  final String status;
  final String price;
  final String description;
  final String propertyType;
  final List<String> propertyImages;

  Property({
    required this.propertyTitle,
    required this.status,
    required this.price,
    required this.description,
    required this.propertyType,
    required this.propertyImages,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyTitle: json['propertyTitle'],
      status: json['status'] ,
      price: json['price'],
      description: json['description'] ,
      propertyType: json['propertyType'] ,
      propertyImages: List<String>.from(json['propertyImages']['\$values'][1]),
    );
  }
}