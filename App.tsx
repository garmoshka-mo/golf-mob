/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, { useEffect, useState } from 'react';
import type {PropsWithChildren} from 'react';
import {
  ScrollView,
  StatusBar,
  StyleSheet,
  Text, TextInput, Button, Alert,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import {watchEvents, sendMessage} from "react-native-watch-connectivity";

type SectionProps = PropsWithChildren<{
  title: string;
}>;

function Section({children, title}: SectionProps): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
}

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };


  
  const [watchMessage, setWatchMessage] = useState("waiting...");
  const messageListener = () => watchEvents.on('message', (message) => {
      setWatchMessage(message)
  })
  useEffect(() => { messageListener() }, [])
  
  
  // useEffect(() => {
  // 	  const unsubscribe = watchEvents.addListener('message', (messageFromWatch, reply) => {
  // 	    console.log({messageFromWatch})
  // 		setWatchMessage(messageFromWatch)
  // 	    reply({text: 'Thanks watch!'})
  // 	  })
  //
  //   return () => {
  //     unsubscribe();
  //   };
  // }, []);
  
  
  
  const safePadding = '5%';
  return (
    <View style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        style={backgroundStyle}>
        <View style={{paddingRight: safePadding}}>
          <Header/>
        </View>
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            paddingHorizontal: safePadding,
            paddingBottom: safePadding,
          }}>
          <Section title="Message from watch">
		   {watchMessage}
          </Section>
		  <Section title="Message to watch">
	  		<Button title="Send message to watch"
	  		    onPress={() =>
	  		        sendMessage(
	  		            {text: "message from phone"}, 
	  			    reply => {console.log(reply)},
	  			    error => { 
	  			        if (error) { 
	  			            Alert.alert("The message can't be sent! The watchOS application is probably not running in the foreground! 🤔")
	  			        }
	  			    }
	  			)
	  		    }
	  		/>
		  </Section>
        </View>
		
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
