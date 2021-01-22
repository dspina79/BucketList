//
//  KPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Dave Spina on 1/21/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Title"
        }
        
        set {
            self.title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown Subtitle"
        }
        
        set {
            self.subtitle = newValue
        }
    }
}
