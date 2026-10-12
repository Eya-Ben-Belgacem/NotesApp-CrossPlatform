import 'package:appwrite/appwrite.dart';

// Valeurs lues depuis env.json (passé avec --dart-define-from-file)
const String appwriteEndpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
const String appwriteProjectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
const String appwriteDatabaseId = String.fromEnvironment('APPWRITE_DATABASE_ID');
const String appwriteTableId = String.fromEnvironment('APPWRITE_TABLE_ID');

final Client client = Client()
  ..setEndpoint(appwriteEndpoint)
  ..setProject(appwriteProjectId);

final TablesDB tablesDB = TablesDB(client);