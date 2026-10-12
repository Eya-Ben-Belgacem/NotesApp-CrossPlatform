/** Transforme n'importe quelle erreur en texte lisible. */
export function errorMessage(e: unknown): string {
  if (e instanceof Error) return e.message;
  return String(e);
}