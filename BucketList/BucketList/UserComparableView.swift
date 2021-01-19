//
//  UserComparableView.swift
//  BucketList
//
//  Created by Dave Spina on 1/18/21.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}

struct UserComparableView: View {
    let users = [
        User(firstName: "Dean", lastName: "Anips"),
        User(firstName: "Theresa", lastName: "Zinter"),
        User(firstName: "Megan", lastName: "McNillan")
    ].sorted()
    var body: some View {
        VStack {
            List(users) { user in
                Text("\(user.lastName), \(user.firstName)")
            }
        }
    }
}

struct UserComparableView_Previews: PreviewProvider {
    static var previews: some View {
        UserComparableView()
    }
}
