import 'react-native-url-polyfill/auto';
import { Client, TablesDB, ID, Query } from 'react-native-appwrite';

const endpoint = process.env.EXPO_PUBLIC_APPWRITE_ENDPOINT!;
const projectId = process.env.EXPO_PUBLIC_APPWRITE_PROJECT_ID!;
const platform = process.env.EXPO_PUBLIC_APPWRITE_PLATFORM!;

export const DATABASE_ID = process.env.EXPO_PUBLIC_APPWRITE_DATABASE_ID!;
export const TABLE_ID = process.env.EXPO_PUBLIC_APPWRITE_TABLE_ID!;

const client = new Client()
  .setEndpoint(endpoint)
  .setProject(projectId)
  .setPlatform(platform);

export const tablesDB = new TablesDB(client);
export { ID, Query };