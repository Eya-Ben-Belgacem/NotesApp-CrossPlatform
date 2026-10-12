# NotesApp-CrossPlatform

Application de notes développée **deux fois, avec les mêmes écrans et les mêmes fonctionnalités** : une version **Flutter** et une version **React Native (Expo)**. Elle correspond au **Lab 1** du cours de développement mobile cross-platform (Teknolabs).

Les notes sont enregistrées dans **Appwrite** (backend cloud). Chaque utilisateur se connecte avec un compte et ne voit **que ses propres notes**.

## Fonctionnalités

- Inscription, connexion et déconnexion (e-mail + mot de passe)
- Session conservée au redémarrage de l'application
- Routes protégées : sans connexion, on est redirigé vers l'écran de connexion
- Écran d'accueil avec l'e-mail de l'utilisateur connecté
- Liste de notes : ajout, modification, suppression (CRUD)
- Notes **privées** par utilisateur
- État vide : « No notes yet » avec un bouton **Create a note**
- Messages d'erreur et indicateur de chargement
- Code découpé en composants réutilisables

## Structure du dépôt

```
NotesApp-CrossPlatform/
├── notes_app/                        # Version Flutter (Dart)
│   ├── lib/
│   │   ├── main.dart                 # Provider + GoRouter (routes protégées)
│   │   ├── appwrite_client.dart      # Client, TablesDB, Account
│   │   ├── models/note.dart          # Note + NoteDraft
│   │   ├── providers/auth_provider.dart   # État d'authentification (ChangeNotifier)
│   │   ├── services/
│   │   │   ├── auth_service.dart     # Appels Appwrite : compte et session
│   │   │   └── notes_service.dart    # CRUD des notes (userId + permissions)
│   │   ├── screens/                  # login, home, notes
│   │   ├── widgets/                  # note_item, note_input_dialog
│   │   └── demos/                    # exemples de style et de mise en page
│   ├── env.json                      # clés Appwrite (NON versionné)
│   └── pubspec.yaml
│
├── notes-app/                        # Version React Native (TypeScript, Expo)
│   ├── src/
│   │   ├── app/                      # Un fichier = une route (Expo Router)
│   │   │   ├── _layout.tsx           # Layout + protection des routes
│   │   │   ├── index.tsx             # Accueil
│   │   │   ├── login.tsx             # Connexion / inscription
│   │   │   └── notes.tsx             # Liste des notes
│   │   ├── components/               # NoteItem, NoteInputModal, EmptyState
│   │   ├── context/AuthContext.tsx   # État d'authentification (Context)
│   │   ├── services/auth.ts          # Appels Appwrite : compte et session
│   │   ├── lib/                      # appwrite.ts, notesService.ts, errors.ts
│   │   ├── demos/                    # exemples de style et de mise en page
│   │   └── types.ts
│   ├── .env                          # clés Appwrite (NON versionné)
│   └── package.json
│
└── README.md
```

## Versions utilisées

| Outil | Version |
|---|---|
| Node.js | 24 LTS |
| Expo SDK | 57 (Expo Router, TypeScript) |
| Flutter | 3.47 |
| Dart | 3.13 |
| Appwrite | Cloud (région Frankfurt), SDK Flutter 27 |
| Git | 2.51 |

## Configuration Appwrite

1. Projet Appwrite Cloud avec une base **TablesDB** et une table `notes`.
2. Colonnes : `title` (text, obligatoire), `content` (text), `userId` (varchar 64).
3. Index sur `userId`.
4. Onglet **Security** de la table : rôle **Users** avec **Create** uniquement, **Row security** activée. Chaque note reçoit des permissions Read/Update/Delete réservées à son propriétaire.
5. Plateformes déclarées dans le projet : Android `com.example.notes_app` (Flutter) et `host.exp.exponent` (Expo Go).

Les clés ne sont jamais écrites dans le code ni commitées.

**Flutter** : créer `notes_app/env.json` (même noms que les `String.fromEnvironment` de `appwrite_client.dart`) :

```json
{
  "APPWRITE_ENDPOINT": "https://fra.cloud.appwrite.io/v1",
  "APPWRITE_PROJECT_ID": "...",
  "APPWRITE_DATABASE_ID": "...",
  "APPWRITE_TABLE_ID": "..."
}
```

**React Native** : créer `notes-app/.env` (variables `EXPO_PUBLIC_*` lues dans `src/lib/appwrite.ts`) :

```
EXPO_PUBLIC_APPWRITE_ENDPOINT=https://fra.cloud.appwrite.io/v1
EXPO_PUBLIC_APPWRITE_PROJECT_ID=...
EXPO_PUBLIC_APPWRITE_DATABASE_ID=...
EXPO_PUBLIC_APPWRITE_TABLE_ID=...
EXPO_PUBLIC_APPWRITE_PLATFORM=host.exp.exponent
```

## Lancer la version Flutter

```bash
cd notes_app
flutter pub get
flutter devices
flutter run --dart-define-from-file=env.json -d emulator-5554
```

1. Démarrer un émulateur Android (Android Studio → Device Manager) avant de lancer.
2. Toujours lancer avec `--dart-define-from-file=env.json` : sans cette option, l'endpoint est vide (erreur « Invalid endpoint URL »).
3. Pendant l'exécution : `r` hot reload, `R` redémarrage complet, `q` quitter.
4. Vérification du code : `flutter analyze`.

## Lancer la version React Native

```bash
cd notes-app
npm install
npx expo start
```

1. Installer **Expo Go** sur le téléphone, le connecter au **même Wi-Fi** que l'ordinateur, puis scanner le QR code.
2. Émulateur Android : appuyer sur `a` dans le terminal.
3. Si le QR code ne fonctionne pas : `npx expo start --tunnel`. Pour vider le cache : `npx expo start -c`.
4. Contrôle de santé : `npx expo-doctor`.

## Comparaison React Native / Flutter

| Concept | React Native (Expo) | Flutter |
|---|---|---|
| Création du projet | `npx create-expo-app@latest` | `flutter create` |
| Langage | TypeScript | Dart |
| Brique d'interface | Composant (fonction qui renvoie du JSX) | Widget (classe avec une méthode `build`) |
| Mise en page | Flexbox (`View` + style) | `Row`, `Column`, `Expanded`, `Padding` |
| Style | `StyleSheet.create`, séparé du composant | propriétés des widgets, thème |
| Longues listes | `FlatList` | `ListView.builder` |
| État local | `useState` | `StatefulWidget` + `setState` |
| État partagé (authentification) | `Context` + hook `useAuth` | `Provider` + `ChangeNotifier` |
| Navigation | Expo Router (un fichier = une route) | `go_router` (liste de `GoRoute`) |
| Routes protégées | redirection dans `_layout.tsx` selon l'utilisateur | `redirect` + `refreshListenable` |
| Formulaire modal | `Modal` + `TextInput` | `showDialog` + `AlertDialog` + `TextField` |
| Champ de saisie | `value` + `onChangeText` | `TextEditingController` + `dispose()` |
| Variables d'environnement | `.env` avec `EXPO_PUBLIC_*` | `env.json` avec `--dart-define-from-file` |
| Appel asynchrone | `async/await` + `try/catch` | `async/await` + `try/catch` + `mounted` |
| Rechargement du code | Fast Refresh | Stateful Hot Reload |

## Ce que j'ai retenu

- Dans les deux frameworks, l'interface est une **fonction de l'état** et se décrit de façon déclarative.
- Les données descendent (props / paramètres), les événements remontent (fonctions).
- Le code est séparé en couches : **écran → service → client Appwrite**. L'écran ne connaît pas les détails de l'API.
- L'état d'authentification est partagé par toute l'application. La navigation réagit à cet état : pas de navigation manuelle après la connexion.
- La confidentialité des notes est garantie par le **serveur** (permissions par ligne), pas seulement par l'interface.
- Les clés secrètes restent hors du dépôt (`.env`, `env.json` dans `.gitignore`).

## Auteure

Eya Ben Belgacem