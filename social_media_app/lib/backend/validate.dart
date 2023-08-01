import 'package:flutter/material.dart';

validateFields(String? email, String? phoneNumber, String? password,
    String? confirmPassword, BuildContext context) {
  // Email validation
  if (email == null || email.isEmpty) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailRegex);
    if (regex.hasMatch(email.toString()))
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
    return 0;
  }
  // Add email validation logic here (e.g., using regex)

  // Phone number validation
  if (phoneNumber == null || phoneNumber.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter your phone number')),
    );
    return 0;
  }
  // Add phone number validation logic here (e.g., using regex)

  // Password validation
  if (password == null || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a password')),
    );
    return 0;
  }
  if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password must be at least 6 characters')),
    );
    return 0;
  }

  // Confirm password validation
  if (confirmPassword == null || confirmPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please confirm your password')),
    );
    return 0;
  }
  if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Passwords do not match')),
    );
    return 0;
  }

  return 1;
}






// String? errorMessage = validateFields(
//   email: _emailController.text,
//   phoneNumber: _phoneNumberController.text,
//   password: _passwordController.text,
//   confirmPassword: _confirmPasswordController.text,
// );

// if (errorMessage != null) {
//   // There's an error in one of the fields, handle it accordingly
// } else {
//   // Fields are valid, proceed with login or registration
// }

