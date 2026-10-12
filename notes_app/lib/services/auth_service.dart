import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import '../appwrite_client.dart';

class AuthService {
  /// Renvoie l'utilisateur connecté, ou null s'il n'y a pas de session valide.
  Future<models.User?> currentUser() async {
    try {
      return await account.get();
    } on AppwriteException {
      return null;
    }
  }

  Future<models.User> signIn(String email, String password) async {
    await account.createEmailPasswordSession(email: email, password: password);
    return account.get();
  }

  Future<models.User> signUp(String name, String email, String password) async {
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    // Créer un compte n'ouvre pas de session : on se connecte juste après
    return signIn(email, password);
  }

  Future<void> signOut() async {
    await account.deleteSession(sessionId: 'current');
  }
}