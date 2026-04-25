import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final success = await auth.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      
      setState(() {
        _isLoading = false;
      });
      
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Background Image
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/images/login.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Main Content
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top Section - Reduced height
                          SizedBox(
                            height: size.height * 0.25,
                            width: double.infinity,
                            child: IgnorePointer(
                              ignoring: true,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Smaller Logo
                                    Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFEE140),
                                            Color(0xFFFA709A),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFA709A).withOpacity(0.3),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.person_add_rounded,
                                        size: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'CREATE ACCOUNT',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 160),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.2),
                                            Colors.white.withOpacity(0.05),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        'JOIN US',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          // Bottom Form Section - Compact version
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, -3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Welcome Section - Compact
                                  const Text(
                                    'Get Started!',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Create your account',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  
                                  // Form - Compact fields
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Full Name Field - Compact
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: TextFormField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: 'FULL NAME',
                                              labelStyle: TextStyle(
                                                color: const Color(0xFFFA709A),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              hintText: 'John Doe',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 11,
                                              ),
                                              prefixIcon: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.person_outline,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 0,
                                              ),
                                            ),
                                            style: const TextStyle(fontSize: 12),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter your name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        
                                        // Email Field - Compact
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: TextFormField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              labelText: 'EMAIL',
                                              labelStyle: TextStyle(
                                                color: const Color(0xFFFA709A),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              hintText: 'hello@example.com',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 11,
                                              ),
                                              prefixIcon: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.email_outlined,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 0,
                                              ),
                                            ),
                                            keyboardType: TextInputType.emailAddress,
                                            style: const TextStyle(fontSize: 12),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter your email';
                                              }
                                              if (!value.contains('@')) {
                                                return 'Valid email required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        
                                        // Password Field - Compact
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              labelText: 'PASSWORD',
                                              labelStyle: TextStyle(
                                                color: const Color(0xFFFA709A),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              hintText: 'Enter password',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 11,
                                              ),
                                              prefixIcon: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.lock_outline,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscurePassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.grey.shade500,
                                                  size: 14,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscurePassword = !_obscurePassword;
                                                  });
                                                },
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 0,
                                              ),
                                            ),
                                            obscureText: _obscurePassword,
                                            style: const TextStyle(fontSize: 12),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter a password';
                                              }
                                              if (value.length < 6) {
                                                return 'Min 6 characters';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        
                                        // Confirm Password Field - Compact
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: TextFormField(
                                            controller: _confirmPasswordController,
                                            decoration: InputDecoration(
                                              labelText: 'CONFIRM',
                                              labelStyle: TextStyle(
                                                color: const Color(0xFFFA709A),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              hintText: 'Confirm password',
                                              hintStyle: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 11,
                                              ),
                                              prefixIcon: Container(
                                                margin: const EdgeInsets.all(8),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                                  ),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.lock_outline,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscureConfirmPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.grey.shade500,
                                                  size: 14,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                                  });
                                                },
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 0,
                                              ),
                                            ),
                                            obscureText: _obscureConfirmPassword,
                                            style: const TextStyle(fontSize: 12),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Confirm password';
                                              }
                                              if (value != _passwordController.text) {
                                                return 'Passwords do not match';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Sign Up Button - Compact
                                  Container(
                                    width: double.infinity,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFA709A).withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _handleRegister,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              'SIGN UP',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // OR Divider - Compact
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 0.5,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          'OR',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 0.5,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Social Sign Up - Compact
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildSocialButton(
                                          icon: Icons.g_mobiledata,
                                          label: 'Google',
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: _buildSocialButton(
                                          icon: Icons.facebook,
                                          label: 'Facebook',
                                          color: const Color(0xFF1877F2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 16),
                                  
                                  // Login Link - Compact
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Have an account? ",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 11,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFFEE140), Color(0xFFFA709A)],
                                            ),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  
                                  // Terms - Compact
                                  Center(
                                    child: Text(
                                      'By signing up, you agree to Terms',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label Sign Up Coming Soon!'),
            backgroundColor: color,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}