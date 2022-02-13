import React from 'react';
import { View, Text, Image, ScrollView, TextInput, StyleSheet } from 'react-native';

const Pizza = (props) => {
    return (
        <View style={{ justifyContent: 'center', alignItems: 'center' }}>
            <Text style={styles.basicText}>Topping: {props.ingredientName}</Text>
            <Image
                source={{ uri: props.imgUrl }}
                style={{ width: 200, height: 200 }}
            />
        </View>
    );
}


const App = () => {
    return (
        <View>
            <View style={{ alignItems: 'center', backgroundColor: '#8fd129' }}>
                <Text>{'\n'}{'\n'}</Text>
                <Image
                    source={{ uri: "https://github.com/EivindBerge/PIZZA-TIME-ACDC-2022/blob/main/theming/pizza-time.png?raw=true" }}
                    style={{ width: 320, height: 320, margin: "5px" }}
                />
                <Text style={styles.titleText}>TMNT Pizza Inspiration App</Text>
            </View>
            <ScrollView>
                <TextInput
                    style={{
                        height: 30,
                        borderColor: 'gray',
                        borderWidth: 1,
                        margin: "5px"
                    }}
                    defaultValue="Search pizza topping..."
                />
                <View>
                    <Pizza ingredientName="Pineapple" imgUrl="https://img.taste.com.au/EnoUrlY0/taste/2016/11/bacon-cheddar-and-pineapple-pizza-77250-1.jpeg"></Pizza>
                    <Pizza ingredientName="Bacon" imgUrl="https://www.lasrecetascocina.com/wp-content/uploads/2017/01/pizza-con-nata-y-bacon.jpg"></Pizza>
                    <Pizza ingredientName="Ham" imgUrl="https://pennysrecipes.com/wp-content/uploads/2020/05/ham-pineapple-pizza.jpg"></Pizza>
                    <Pizza ingredientName="Mushroom" imgUrl="https://www.thursdaynightpizza.com/wp-content/uploads/2021/05/finished-without-chives_STAMP.png"></Pizza>
                </View>
            </ScrollView>
        </View>
    );
}

const styles = StyleSheet.create({
    baseText: {
        fontFamily: "Cochin"
    },
    titleText: {
        fontSize: 20,
        fontWeight: "bold",
        fontFamily: "Cochin"
    }
});

export default App;