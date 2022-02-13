import * as React from "react";
import { useEffect, useRef, useState } from 'react';

type GoogleLatLng = google.maps.LatLng;
type GoogleMap = google.maps.Map;
type GoogleMarker = google.maps.Marker;
type GooglePolyline = google.maps.Polyline;


interface ISimpleMap {
    test: string;
}

const SimpleMap: React.FC<ISimpleMap> = ({

}) => {
    const ref = useRef<HTMLDivElement>(null);
    const [map, setMap] = useState<GoogleMap>();


    const startMap = (): void => {
        if (!map) {
            initMap(4, new google.maps.LatLng(65.166013499, 13.3698147));
        }
    }
    useEffect(startMap, [map]);

    const initMap = (zoomLevel: number, address: GoogleLatLng): void => {
        if (ref.current) {
            setMap(
                new google.maps.Map(ref.current, {
                    zoom: zoomLevel,
                    center: address,
                    streetViewControl: false,
                    rotateControl: false,
                    scaleControl: true,
                    fullscreenControl: false,
                    panControl: false,
                    zoomControl: true,
                    gestureHandling: 'cooperative',
                    draggableCursor: 'pointer',
                })
            );
        }
    };

    return (
        <div>
            <div style={{ height: "600px" }} ref={ref}></div>
        </div>
    );
}

export default SimpleMap;