import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool isPasswordVisible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar("Please fill in all fields", Colors.red);
      return;
    }

    showSnackbar("Logged in successfully!", Colors.green);
    widget.onLoginSuccess();
  }

  void register() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackbar("Please fill in all fields", Colors.red);
      return;
    }

    if (password != confirmPassword) {
      showSnackbar("Passwords do not match", Colors.red);
      return;
    }

    showSnackbar("Account created successfully!", Colors.green);
    widget.onLoginSuccess();
  }

  void googleSignIn() {
    showSnackbar("Google Sign-In is not implemented yet", Colors.orange);
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isLogin ? "Login to Your Account" : "Create an Account",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                if (!isLogin)
                  _buildTextField(nameController, "Full Name", Icons.person),
                if (!isLogin) const SizedBox(height: 16),

                _buildTextField(emailController, "Email", Icons.email),
                const SizedBox(height: 16),

                _buildPasswordField(passwordController, "Password"),
                const SizedBox(height: 16),

                if (!isLogin)
                  _buildPasswordField(
                    confirmPasswordController,
                    "Confirm Password",
                  ),
                if (!isLogin) const SizedBox(height: 20),

                _buildActionButton(),
                const SizedBox(height: 12),

                _buildGoogleSignInButton(),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => setState(() => isLogin = !isLogin),
                  child: Text(
                    isLogin
                        ? "Don't have an account? Register"
                        : "Already have an account? Login",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed:
              () => setState(() => isPasswordVisible = !isPasswordVisible),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLogin ? login : register,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          isLogin ? "Login" : "Register",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: googleSignIn,
        icon: const Icon(Icons.login, color: Colors.red),
        label: const Text(
          "Login with Google",
          style: TextStyle(color: Colors.red),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
