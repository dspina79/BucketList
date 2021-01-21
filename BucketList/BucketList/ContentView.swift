//
//  ContentView.swift
//  BucketList
//
//  Created by Dave Spina on 1/18/21.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingDetails = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingDetails, annotations: locations)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.title = "Example Location"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
            .alert(isPresented: $showingDetails){
                Alert(title: Text(selectedPlace?.title ?? "Unknown Place"), message: Text(selectedPlace?.subtitle ?? "Missing Details"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Edit")){
                    //edit this place
                })
            }
        }
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // there's a problem
                    }
                }
            }
        }  else {
            // there's no biometrics
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
