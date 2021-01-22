//
//  EditView.swift
//  BucketList
//
//  Created by Dave Spina on 1/21/21.
//

import MapKit
import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var pointMark: MKPointAnnotation
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $pointMark.wrappedTitle)
                    TextField("Subtitle", text: $pointMark.wrappedSubtitle)
                }
            }.navigationBarTitle("Edit Place")
            .navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(pointMark: MKPointAnnotation.example)
    }
}
