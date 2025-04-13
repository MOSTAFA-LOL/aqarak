// class RealEstateModel {
//   final int propertyId;
//   final String propertyTitle;
//   final String propertyType;
//   final double price;
//   final String status;
//   final String city;
//   final String address;
//   final String googleMapsLink;
//   final int totalRooms;
//   final int bathrooms;
//   final int bedrooms;
//   final int floorNumber;
//   final int area;
//   final bool furnished;
//   final String description;
//   final DateTime createdAt;
//   final PropertyImages propertyImages;
//   final String userId;

//   RealEstateModel({
//     required this.propertyId,
//     required this.propertyTitle,
//     required this.propertyType,
//     required this.price,
//     required this.status,
//     required this.city,
//     required this.address,
//     required this.googleMapsLink,
//     required this.totalRooms,
//     required this.bathrooms,
//     required this.bedrooms,
//     required this.floorNumber,
//     required this.area,
//     required this.furnished,
//     required this.description,
//     required this.createdAt,
//     required this.propertyImages,
//     required this.userId,
//   });

//   factory RealEstateModel.fromJson(Map<String, dynamic> json) {
//     return RealEstateModel(
//       propertyId: json['propertyId'] ,
//       propertyTitle: json['propertyTitle'] ,
//       propertyType: json['propertyType'] ,
//       price: (json['price']).toDouble(),
//       status: json['status'] ,
//       city: json['city'] ,
//       address: json['address'] ,
//       googleMapsLink: json['googleMapsLink'] ,
//       totalRooms: json['totalRooms'] ,
//       bathrooms: json['bathrooms'] ,
//       bedrooms: json['bedrooms'] ,
//       floorNumber: json['floorNumber'] ,
//       area: json['area'] ,
//       furnished: json['furnished'] ,
//       description: json['description'] ,
//       createdAt: DateTime.parse(json['createdAt'] ),
//       propertyImages: PropertyImages.fromJson(json['propertyImages']),
//       userId: json['userId'] ,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'propertyId': propertyId,
//       'propertyTitle': propertyTitle,
//       'propertyType': propertyType,
//       'price': price,
//       'status': status,
//       'city': city,
//       'address': address,
//       'googleMapsLink': googleMapsLink,
//       'totalRooms': totalRooms,
//       'bathrooms': bathrooms,
//       'bedrooms': bedrooms,
//       'floorNumber': floorNumber,
//       'area': area,
//       'furnished': furnished,
//       'description': description,
//       'createdAt': createdAt.toIso8601String(),
//       'propertyImages': propertyImages.toJson(),
//       'userId': userId,
//     };
//   }
  
// }
// class PropertyImages {
//   final List<dynamic> images;

//   PropertyImages({required this.images});

//   factory PropertyImages.fromJson(Map<String, dynamic> json) {
//     return PropertyImages(
//       images: List<dynamic>.from(json['\$values'] as List),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '\$values': images,
//     };
//   }
// }
// class PropertyResponse {
//   final String id;
//   final List<RealEstateModel> properties;

//   PropertyResponse({required this.id, required this.properties});

//   factory PropertyResponse.fromJson(Map<String, dynamic> json) {
//     return PropertyResponse(
//       id: json['\$id'] as String,
//       properties: (json['\$values'] as List)
//           .map((item) => RealEstateModel.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       '\$values': properties.map((property) => property.toJson()).toList(),
//     };
//   }
// }



