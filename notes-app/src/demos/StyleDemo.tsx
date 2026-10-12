import { StyleSheet, Text, View } from 'react-native';

export default function StyleDemo() {
  return (
    <View style={styles.container}>
      <View style={styles.box}>
        <Text style={styles.text}>Styled Component</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#f5f5f5',
  },
  box: {
    width: 200,
    height: 200,
    backgroundColor: '#3498db',
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
    // Ombre multiplateforme (iOS, Android et web)
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.25)',
  },
  text: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
});