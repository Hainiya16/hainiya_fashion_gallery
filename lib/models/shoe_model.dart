// models/shoe_model.dart (Updated with Sri Lankan Rupee - LKR prices & English descriptions)
class Shoe {
  final String id;
  final String name;
  final String brand;
  final double price; // Price in Sri Lankan Rupees (LKR)
  final String imageUrl;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviews;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.sizes,
    required this.colors,
    required this.rating,
    required this.reviews,
  });
}

// Sample shoes data with Sri Lankan Rupee (LKR) prices and English descriptions
List<Shoe> sampleShoes = [
  Shoe(
    id: '1',
    name: 'Air Max 2024',
    brand: 'Nike',
    price: 2899, // LKR - Sri Lankan Rupees
    imageUrl: 'assets/images/1.jpg',
    description: 'Ultimate comfort with air cushioning technology. Perfect for running and casual wear. Features lightweight mesh upper and responsive cushioning for all-day comfort.',
    sizes: ['7', '8', '9', '10', '11'],
    colors: ['Black', 'White', 'Red'],
    rating: 4.5,
    reviews: 128,
  ),
  Shoe(
    id: '2',
    name: 'Ultraboost 22',
    brand: 'Adidas',
    price: 4299, // LKR
    imageUrl: 'assets/images/2.jpg',
    description: 'Energy return with every step. Best for long runs. Made with recycled materials and features Boost technology for maximum comfort and performance.',
    sizes: ['7', '8', '9', '10'],
    colors: ['Blue', 'Black', 'Grey'],
    rating: 4.8,
    reviews: 256,
  ),
  Shoe(
    id: '3',
    name: 'Classic Leather',
    brand: 'Reebok',
    price: 1999, // LKR
    imageUrl: 'assets/images/3.jpg',
    description: 'Timeless design with premium leather. Durable construction perfect for everyday wear. Features cushioned insole for all-day comfort and support.',
    sizes: ['6', '7', '8', '9', '10'],
    colors: ['White', 'Black'],
    rating: 4.3,
    reviews: 89,
  ),
  Shoe(
    id: '4',
    name: 'Running Pro',
    brand: 'Puma',
    price: 2499, // LKR
    imageUrl: 'assets/images/4.jpg',
    description: 'Lightweight and breathable for maximum performance. Ideal for serious runners. Features advanced traction system and moisture-wicking technology.',
    sizes: ['7', '8', '9', '10', '11'],
    colors: ['Yellow', 'Black', 'Pink'],
    rating: 4.6,
    reviews: 167,
  ),
  Shoe(
    id: '5',
    name: 'Retro Classic',
    brand: 'New Balance',
    price: 2799, // LKR
    imageUrl: 'assets/images/1.jpg',
    description: 'Vintage style meets modern comfort. Perfect for everyday casual wear. Features premium suede upper and classic design elements.',
    sizes: ['8', '9', '10', '11'],
    colors: ['Grey', 'Navy', 'Brown'],
    rating: 4.7,
    reviews: 203,
  ),
  Shoe(
    id: '6',
    name: 'Venture Runner',
    brand: 'ASICS',
    price: 2299, // LKR
    imageUrl: 'assets/images/2.jpg',
    description: 'Durable outsole for trail running. Excellent grip on various terrains. Features gel cushioning technology for impact protection.',
    sizes: ['7', '8', '9', '10'],
    colors: ['Green', 'Black', 'Orange'],
    rating: 4.4,
    reviews: 145,
  ),
];