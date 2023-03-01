class LoginForm {
  final String username;
  final String password;

  const LoginForm({required this.username, required this.password});

  @override
  String toString() {
    return "username : $username, password : $password";
  }
}
