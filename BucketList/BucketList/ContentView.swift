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
    @State private var showBiometricErrors = false
    @State private var biometricError: String = "Unknown biometric error"
    
    var body: some View {
        ZStack {
            if isUnlocked {
                CompositeMapView()
            } else {
                Button("Unlock") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }.alert(isPresented: $showBiometricErrors) {
            Alert(title: Text("Biometric Error"), message: Text(self.biometricError), dismissButton: .default(Text("Understood")))
        }
        
    }
   
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked  = true
                    } else {
                        self.biometricError = "The facial ID recognition failed. Cannot unlock."
                        self.showBiometricErrors = true
                    }
                }
            }
        } else {
            self.biometricError = "Authentication failure: " + (error?.localizedDescription ?? "Uknown error")
            self.showBiometricErrors = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
