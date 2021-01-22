//
//  EditView.swift
//  BucketList
//
//  Created by Dave Spina on 1/21/21.
//

import MapKit
import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var pointMark: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $pointMark.wrappedTitle)
                    TextField("Subtitle", text: $pointMark.wrappedSubtitle)
                }
                Section(header: Text("Nearby...")) {
                    if self.loadingState == .loaded {
                        List(pages, id: \.pageid) { page in
                            Text("\(page.title)")
                                .font(.headline)
                            + Text(": ")
                            + Text("Page Description Here")
                                .italic()
                        }
                    } else if self.loadingState == .loading {
                        Text("Currently Loading...")
                    } else {
                        Text("There was an issue. Please try again later.")
                    }
                }
            }.navigationBarTitle("Edit Place")
            .navigationBarItems(trailing: Button("Done"){
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchPlaces)
        }
    }
    
    func fetchPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(pointMark.coordinate.latitude)%7C\(pointMark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let items = try? decoder.decode(Result.self, from: data) {
                    self.pages = Array(items.query.pages.values)
                    self.loadingState = .loaded
                    return
                }
                
                self.loadingState = .failed
            }
        }.resume()

    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(pointMark: MKPointAnnotation.example)
    }
}
