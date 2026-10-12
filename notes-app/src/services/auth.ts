import { ID, type Models } from 'react-native-appwrite';

import { account } from '../lib/appwrite';

export type User = Models.User<Models.DefaultPreferences>;

/** Renvoie l'utilisateur connecté, ou null s'il n'y a pas de session valide. */
export async function getCurrentUser(): Promise<User | null> {
  try {
    return await account.get();
  } catch {
    return null;
  }
}

export async function signIn(email: string, password: string): Promise<User> {
  await account.createEmailPasswordSession({ email, password });
  return account.get();
}

export async function signUp(name: string, email: string, password: string): Promise<User> {
  await account.create({ userId: ID.unique(), email, password, name });
  // Créer un compte n'ouvre pas de session : on se connecte juste après
  return signIn(email, password);
}

export async function signOut(): Promise<void> {
  await account.deleteSession({ sessionId: 'current' });
}