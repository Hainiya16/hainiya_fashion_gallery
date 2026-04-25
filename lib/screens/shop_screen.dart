// screens/shop_screen.dart (Complete with header)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/shoe_card.dart';
import '../widgets/custom_header.dart';
import '../models/shoe_model.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String searchQuery = '';
  String selectedFilter = 'Featured';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Shoe> get filteredShoes {
    List<Shoe> shoes = sampleShoes;
    
    if (searchQuery.isNotEmpty) {
      shoes = shoes.where((shoe) => 
        shoe.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        shoe.brand.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    if (selectedFilter == 'Nike') {
      shoes = shoes.where((shoe) => shoe.brand == 'Nike').toList();
    } else if (selectedFilter == 'Adidas') {
      shoes = shoes.where((shoe) => shoe.brand == 'Adidas').toList();
    } else if (selectedFilter == 'Puma') {
      shoes = shoes.where((shoe) => shoe.brand == 'Puma').toList();
    } else if (selectedFilter == 'Under 20000') {
      shoes = shoes.where((shoe) => shoe.price < 20000).toList();
    } else if (selectedFilter == '20000-30000') {
      shoes = shoes.where((shoe) => shoe.price >= 20000 && shoe.price <= 30000).toList();
    } else if (selectedFilter == 'Above 30000') {
      shoes = shoes.where((shoe) => shoe.price > 30000).toList();
    }
    
    return shoes;
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF00BCD4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomHeader(
        title: 'All Shoes',
        onMenuTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        },
        profileImageUrl: auth.profileImageUrl,
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        cartItemCount: cartProvider.itemCount,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for shoes...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFA709A)),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          
          // Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Shop Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedFilter,
                      icon: const Icon(Icons.filter_list, color: Colors.white, size: 16),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      items: const [
                        DropdownMenuItem(value: 'Featured', child: Text('Featured', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: 'Nike', child: Text('Nike', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: 'Adidas', child: Text('Adidas', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: 'Puma', child: Text('Puma', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: 'Under 20000', child: Text('Under Rs.20,000', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: '20000-30000', child: Text('Rs.20,000 - 30,000', style: TextStyle(color: Color(0xFF2C3E50)))),
                        DropdownMenuItem(value: 'Above 30000', child: Text('Above Rs.30,000', style: TextStyle(color: Color(0xFF2C3E50)))),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Products Grid
          Expanded(
            child: filteredShoes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              selectedFilter = 'Featured';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFA709A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Clear Filters'),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredShoes.length,
                    itemBuilder: (context, index) {
                      final shoe = filteredShoes[index];
                      return ShoeCard(
                        shoe: shoe,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                shoe: shoe,
                              ),
                            ),
                          );
                        },
                        onCartTap: () {
                          final cartProviderLocal = Provider.of<CartProvider>(
                            context,
                            listen: false,
                          );
                          
                          cartProviderLocal.addToCart(
                            shoe,
                            size: shoe.sizes.first,
                            color: shoe.colors.first,
                          );
                          
                          _showNotification('${shoe.name} added to cart');
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}