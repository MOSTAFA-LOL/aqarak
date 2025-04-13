// ignore: file_names
class EndPoint {
  static String baseUrl = "http://mshmsh-001-site1.qtempurl.com/api/";
  static String signIn = "auth/login";
  static String signUp = "users";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static String email = "Email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String name = "name";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  // static String location = "location";
  // static String profilePic = "profilePic";
}