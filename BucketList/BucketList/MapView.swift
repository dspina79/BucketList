//
//  MapView.swift
//  BucketList
//
//  Created by Dave Spina on 1/19/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let mkView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            mkView.canShowCallout = true
            return mkView
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "Washington, DC"
        annotation.subtitle = "Capital of the United States"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.53, longitude: -77.2)
        mapView.addAnnotation(annotation)
        
        let annotation2 = MKPointAnnotation()
        annotation2.title = "Los Angeles"
        annotation2.subtitle = "California"
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 34.05, longitude: -118.24)
        mapView.addAnnotation(annotation2)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
