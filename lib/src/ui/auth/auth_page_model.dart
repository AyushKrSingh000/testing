import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../logic/services/firebase_auth.dart';
import '../../../logic/services/firebase_firestore.dart';

part 'auth_page_model.freezed.dart';

final authPageModelProvider =
    StateNotifierProvider.autoDispose<AuthPageModel, AuthPageState>(
  (ref) => AuthPageModel(
      firebaseAuth: ref.watch(firebaseAuthProvider),
      googleSignIn: ref.watch(googleAuthProvider),
      firebaseFirestore: ref.watch(firebaseFirestoreProvider)),
);

class AuthPageModel extends StateNotifier<AuthPageState> {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firebaseFirestore;

  AuthPageModel(
      {required this.firebaseAuth,
      required this.googleSignIn,
      required this.firebaseFirestore})
      : super(const AuthPageState());
  Future<String> signin() async {
    state = state.copyWith(
      status: AuthPageStatus.authenticating,
    );

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final domain = googleSignInAccount?.email.split('@')[1];
    if (domain != 'thapar.edu') {
      state = state.copyWith(
        status: AuthPageStatus.initial,
      );
      googleSignIn.disconnect();

      return 'Please Sign in With Thapar Id';
    }
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    state = state.copyWith(
      status: AuthPageStatus.authenticated,
    );
    return '';
  }
}

@freezed
class AuthPageState with _$AuthPageState {
  const factory AuthPageState({
    @Default(AuthPageStatus.initial) AuthPageStatus status,
    String? errorMessage,
  }) = _AuthPageState;
}

enum AuthPageStatus {
  initial,
  authenticating,
  authenticated,
  error,
}
