import 'package:aqarak/cubit/user_state.dart';
import 'package:aqarak/newapi/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final ApiService _apiService = ApiService();

  final signInFormKey = GlobalKey<FormState>();
  final signInEmail = TextEditingController();
  final signInPassword = TextEditingController();
  final signInid = TextEditingController();
  final signInname = TextEditingController();
  final signInimage = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();
  final signUpEmail = TextEditingController();
  final signUpPassword = TextEditingController();
  final signUpName = TextEditingController();
  final signUpPhone = TextEditingController();

  String? currentUserEmail;
  String? currentUserName;
  String? currentUserPhone;
  String? currentUserToken;
  String? currentUserId;
  String? currentUserImage;  

  Future<void> signIn() async {
    if (!signInFormKey.currentState!.validate()) {
      return;
    }

    emit(SignInLoading());
    try {
      final response = await _apiService.signIn(
        signInEmail.text,
        signInPassword.text,
      );
      currentUserEmail = signInEmail.text;
      currentUserName = response.data['user'] != null ? response.data['user']['name'] ?? '' : '';
      currentUserPhone = response.data['user'] != null ? response.data['user']['phone'] ?? '' : '';
      currentUserToken = response.data['token'];
      currentUserId = response.data['user']['id'];
      currentUserImage = response.data['user']['image'];
      // Clear the sign up form

      emit(SignInSuccess(response.data['token']));
    } catch (e) {
      emit(SignInFailure(e.toString()));
      print(e);
      
    } 
  }

  Future<void> signUp() async {
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }

    emit(SignUpLoading());
    try {
      final response = await _apiService.signUp(
        signUpEmail.text,
        signUpPassword.text,
        signUpName.text,
        signUpPhone.text,
      );
      currentUserEmail = signUpEmail.text;
      currentUserName = response.data['user'] != null ? response.data['user']['name'] ?? '' : '';
      currentUserPhone = response.data['user'] != null ? response.data['user']['phone'] ?? '' : '';
      currentUserToken = response.data['token'];
      currentUserId = response.data['user']['id'];
      currentUserImage = response.data['user']['image'];
      // Clear the sign up form
      signUpEmail.clear();
      signUpPassword.clear();
      signUpName.clear();
      signUpPhone.clear();
      // Switch to login mode
      emit(SignUpSuccess(response.data['token']));
      print(currentUserId);
      // Automatically fill the login form with the registered email
      signInEmail.text = signUpEmail.text;
      // Sign in automatically to fetch user data
      await signIn();
    } catch (e) {
      emit(
        SignUpFailure(e.toString()),
      );
    }
  }
}
