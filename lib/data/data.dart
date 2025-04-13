class House {
  final String price;
  final String id;
  final String status;
  final String  location;
  final String city;
  final String image;
  final String name;
  final String place;
  final String beds;
  final String baths;
  final String size;
  final String rate;
  final String details;
  final String company;
  final String description;

  House(
      {required this.image,
      required this.price,
      required this.id,
      required this.name,
      required this.place,
      required this.beds,
      required this.baths,
      required this.size,
      required this.rate,
      required this.city,
      required this.description,
      required this.details,
      required this.company,
      required this.location,
      required this.status,

      });
}

List<House> realEstatemodel = [
  House(
      image: 'assets/images/OIF.jpg',
      price: '\$1,129',
      name: 'La Grand maison',
      place: 'Mrlr,Australia',
      beds: '5',
      baths: '4',
      size: '500',
      rate: '4.9',
      description: description,
      city: '', details: '', company: '', location: '', status: '', id: ''),
  House(
      image: 'assets/images/th (1).jpg',
      price: '\$2,888',
      name: 'Da modern house',
      place: 'madred,espan',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.3',
        id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/OIF (2).jpg',
      price: '\$9,995',
      name: 'whitespace',
      place: 'togo,brazil',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.7',
          id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/OIF (1).jpg',
      price: '\$5,122',
      name: 'nature place',
      place: 'lolwa,England',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.5',
          id: '',
      description: description,
      details: '', company: '', location: '', status: '',
      city: ''),
];
String description = 'Luxury villa with prime location, featuring large garden and private pool.';
List<House> realEstatemodelcard = [
  House(
      image: 'assets/images/new-york.png',
      price: '\$1,129',
      name:"فيلا فاخرة مطلة على البحر",
      place: 'مصر',
      beds: '6',
      baths: '4',
      rate: '5',
      size: '11,000متر /مربع',
      id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/bec1a4fa3ce5cd83809725ef5dc9e9a9.jpg',
      price: '\$2,888',
      name: 'منازل حديثه',
      place: 'اسبانيا',
      beds: '2',
      baths: '4',
      rate: '4,6',
      id: '',
      size: '8,000متر /مربع',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
            image: 'assets/images/new-york.png',
      price: '\$9,995',
      name: 'مساحات واسعه',
      place: 'البرازيل',
      beds: '5',
      baths: '6',
      size: '500',
      rate: '4.9',
      id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/759668028-800x600.jpeg',
      price: '\$5,122',
      name: 'شقق تطل علي الطبيعه',
      place: 'انجلترا',
      beds: '8',
      baths: '4',
      rate: '4,3',
      size: '18,000متر /مربع',
      id: '',
      description: description1, city: '', details: '', company: '', location: '', status: ''),
      
];
String description1 = 'Luxury villa with prime location, featuring large garden and private pool.';

List<House> realEstatemodelSearch = [
  House(
      image: 'assets/images/OIF (1).jpg',
      price: '\$1,129',
      name: 'جناح شمالي',
      place: 'استرليا',
      beds: '5',
      baths: '4',
      size: '500',
      id: '',
      rate: '4.9', details: '', company: '', location: '', status: '',
      description: description, city: ''),
  House(
      image: 'assets/images/th (1).jpg',
      price: '\$2,888',
      name: 'غرف ترفيهيه',
      place: 'مدريد,اسبانيا',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.3',
        id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/OIF (2).jpg',
      price: '\$9,995',
      name: 'غرف مثاليه',
      place: 'البرازيل',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.7',
        id: '',
      description: description, city: '', details: '', company: '', location: '', status: ''),
  House(
      image: 'assets/images/OIF (1).jpg',
      price: '\$5,122',
      name: 'اماكن طبيعيه',
      place: 'انجلترا',
      beds: '5',
      baths: '4',
      size: '500',
        rate: '4.5',
        id: '',
      description: description2,
      details: '', company: '', location: '', status: '',
        city: ''),
];
String description2 = 'Luxury villa with prime location, featuring large garden and private pool.';

