# NotesApp-CrossPlatform

Application de notes développée **deux fois, avec le même design et les mêmes fonctionnalités** : une version **React Native (Expo)** et une version **Flutter**. Ce projet correspond au **Lab 1 - Partie 1** du cours de développement mobile cross-platform (Teknolabs).

L'objectif est de comparer les deux frameworks côte à côte : langage, composants, gestion de l'état, navigation et organisation du code.

## Fonctionnalités

- Écran d'accueil avec message de bienvenue et bouton « Go to Notes »
- Navigation entre l'écran d'accueil et l'écran des notes
- CRUD complet des notes :
  - **Create** : bouton **+** et boîte de saisie
  - **Read** : liste des notes (message « No notes yet. Create one! » si la liste est vide)
  - **Update** : bouton **Edit** avec texte pré-rempli
  - **Delete** : bouton **Delete**
- Code découpé en composants réutilisables (`NoteItem`, `NoteInput` / `NoteInputDialog`)

## Structure du dépôt

```
NotesApp-CrossPlatform/
├── flutter_app/              # Version Flutter (Dart)
│   ├── lib/
│   │   ├── main.dart         # Point d'entrée + routes
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   └── notes_screen.dart
│   │   └── components/
│   │       ├── note_item.dart
│   │       └── note_input_dialog.dart
│   └── pubspec.yaml
│
├── react-native/             # Version React Native (JavaScript, Expo)
│   ├── App.js                # Point d'entrée + navigation
│   ├── screens/
│   │   ├── HomeScreen.js
│   │   └── NotesScreen.js
│   ├── components/
│   │   ├── NoteItem.js
│   │   └── NoteInput.js
│   └── package.json
│
└── README.md
```

## Prérequis

| Outil | Version testée | Utilisé pour |
|---|---|---|
| Node.js | 20.x | React Native (Expo) |
| npm | 11.x | Gestion des dépendances JS |
| Expo Go (téléphone) | dernière version | Tester l'appli React Native |
| Flutter SDK | dernière version stable | Version Flutter |
| Android Studio + émulateur | dernière version | Tester l'appli Flutter |
| Git | - | Versionnement |

## Lancer la version React Native

```bash
cd react-native
npm install
npx expo start
```

1. Scanner le QR code avec l'application **Expo Go** (téléphone et PC sur le même Wi-Fi).
2. Si le QR code ne fonctionne pas : `npx expo start --tunnel`.

## Lancer la version Flutter

```bash
cd flutter_app
flutter pub get
flutter run
```

1. Vérifier l'installation avec `flutter doctor`.
2. Démarrer un émulateur Android (ou brancher un téléphone en mode débogage USB) avant `flutter run`.
3. Pendant l'exécution : `r` = hot reload, `R` = hot restart.

## Comparaison React Native / Flutter

| Concept | React Native | Flutter |
|---|---|---|
| Langage | JavaScript | Dart |
| Conteneur | `View` | `Container` |
| Styles | `StyleSheet.create` | Directement dans les widgets |
| Remplir l'espace | `flex: 1` | `Expanded` |
| Navigation | `@react-navigation` (à installer) | `Navigator` + `routes` (intégré) |
| État local | `useState` | `StatefulWidget` + `setState()` |
| Liste | `FlatList` | `ListView.builder` |
| Saisie | `Modal` + `TextInput` | `AlertDialog` + `TextField` |
| Données vers un composant | props | paramètres du constructeur |

## Historique du travail (Git)

Le projet a été construit étape par étape, avec un commit par étape clé :

1. Création des projets Expo et Flutter
2. Mise en place du layout (header / content / footer)
3. Navigation Home → Notes
4. CRUD complet de l'écran Notes
5. Refactoring en composants réutilisables

## Suite du projet

- **Partie 2** : intégration d'une base de données avec Appwrite
- **Partie 3** : authentification
- **Partie 4** : déploiement et publication

## Auteure

Eya Ben Belgacem
