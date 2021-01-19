//
//  DocumentsWritingView.swift
//  BucketList
//
//  Created by Dave Spina on 1/18/21.
//

import SwiftUI

struct DocumentsWritingView: View {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        let messageString = "This is the next level!"
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let url = getDocumentsDirectory().appendingPathComponent("mytext.txt")
                do {
                    try messageString.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct DocumentsWritingView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsWritingView()
    }
}
