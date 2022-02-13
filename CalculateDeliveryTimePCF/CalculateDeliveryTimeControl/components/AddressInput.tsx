import * as React from "react";
import { useEffect, useState } from "react";
import { loadMapApi } from "../utils/GoogleMapsUtils";
import { IInputs, IOutputs } from "../generated/ManifestTypes";
import Map from './Map/Map';
import SimpleMap from "./Map/SimpleMap";

export interface IAddressInput {
    testStringVariable: string;
    context: ComponentFramework.Context<IInputs>;
}


const AddressInput: React.FC<IAddressInput> = ({
    testStringVariable,
    context
}) => {
    const [deliveryaddress, setDeliveryAddress] = useState("");
    const [scriptLoaded, setScriptLoaded] = useState(false);
    const [distanceInKm, setDistanceInKm] = useState<number>(-1);
    const [weatherDescription, setWeatherDescription] = useState("");
    const [position, setPosition] = useState<any>();

    useEffect(() => {
        const googleMapScript = loadMapApi();
        googleMapScript.addEventListener('load', function () {
            setScriptLoaded(true);
        });
    }, []);

    useEffect(() => {
        if (context.client.getClient() === "Web") {
            navigator.geolocation.getCurrentPosition(position => {
                console.log("Client: Web");
                console.log(position.coords);
                setPosition(position.coords)
            })
        } else {
            context.device.getCurrentPosition()
                .then(result => {
                    console.log("Client: Mobile");
                    console.log(result.coords)
                    setPosition(result.coords);
                })
        }
    }, []);

    const renderDistanceSentence = () => {

        fetch("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/manhattan?unitGroup=metric&key=G5NGC7CZTCJBVHKDTRGVD668G&contentType=json")
            .then(response => response.json())
            .then(data => {
                console.log(data.description);
                setWeatherDescription(data.description)
            });

        return (
            <div style={{ height: "120px", width: "600px" }}>
                {`Distance between selected marker and home address is 5911 km.`}
                <br />
                {`Delivery time: 34261 min.`}
                <br />
                <br />
                {`Current New York weather: ${weatherDescription}`}
                <br />
                {`\nCurrent weather might affect delivery time.`}
            </div>
        );
    };

    const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        console.log("Delivery address was submitted: " + event.target.value)
        setDeliveryAddress(event.target.value)
    }

    // {`Distance between selected marker and home address is ${distanceInKm}km.`}
    // distanceInKm > -1 && 

    return (
        <div style={{ alignItems: 'center', backgroundColor: '#8fd129' }}>
            <div style={{ margin: "5px" }}>
                <label htmlFor="deliveryaddress">Delivery address:</label>
                <input type="text" id="deliveryaddress" placeholder="Where would you like the deliciousness served...?" value={deliveryaddress} onChange={handleChange} name="deliveryaddress"></input>
            </div>
            <div>
                {scriptLoaded && position && (
                    <Map
                        mapType={google.maps.MapTypeId.ROADMAP}
                        mapTypeControl={true}
                        setDistanceInKm={setDistanceInKm}
                        position={position}
                    />
                )}
                {renderDistanceSentence()}
            </div>
        </div>
    );
};

export default AddressInput;