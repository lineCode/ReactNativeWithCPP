import React from 'react';
import { StyleSheet, Text, View, NativeModules } from 'react-native';

export default class App extends React.Component {
  render() {
    NativeModules.TestCPP.show();
    return (
      <View style={styles.container}>
        <Text>ReactAppAR with C++</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
