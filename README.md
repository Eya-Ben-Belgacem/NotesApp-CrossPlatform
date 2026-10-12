\# NotesApp — Cross-Platform Mobile Development



\## 1. Project Overview



NotesApp is a mobile application developed in two versions to explore cross-platform development:



\- \*\*Flutter:\*\* implemented with Dart.

\- \*\*React Native:\*\* implemented with TypeScript and Expo.



Both versions provide a simple interface for managing notes.



\## 2. Project Structure



```text

NotesApp-CrossPlatform/

├── notes\_app/    # Flutter application

└── notes-app/    # React Native application

```



\## 3. Features



Both applications allow users to:



\- Display a list of notes.

\- Create a note with a title and content.

\- Edit an existing note.

\- Delete a note.



\## 4. Technologies Used



| Aspect | Flutter | React Native |

|---|---|---|

| Programming language | Dart | TypeScript |

| UI elements | Widgets | React components |

| Styling | Widget properties and decoration | StyleSheet |

| Layout | Row, Column, Expanded | Flexbox |

| Development tools | Flutter SDK | React Native, Expo |

| Main entry point | `lib/main.dart` | `src/app/` |

| Code reuse | Reusable widgets | Reusable components |



\## 5. Running the Applications



\### Flutter



Requirements: Flutter SDK and an available emulator or connected device.



```bash

cd notes\_app

flutter pub get

flutter run

```



To analyze the Flutter code:



```bash

flutter analyze

```



\### React Native



Requirements: Node.js, npm and Expo Go or an Android emulator.



```bash

cd notes-app

npm install

npx expo start

```



For a phone connected to a different network, a tunnel may be attempted with:



```bash

npx expo start --tunnel

```



\### Notes



The applications are maintained in separate folders and can be launched independently. Follow the instructions in each folder's README for any additional setup.



