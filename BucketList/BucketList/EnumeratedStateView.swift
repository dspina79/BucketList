//
//  EnumeratedStateView.swift
//  BucketList
//
//  Created by Dave Spina on 1/18/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

struct FailureView: View {
    var body: some View {
        Text("Failure")
            .foregroundColor(.red)
    }
}


struct EnumeratedStateView: View {
    enum LoadingState {
        case load, success, failure
    }
    
    @State var currentState: LoadingState = .load
    
    var body: some View {
        Group {
                VStack {
                if currentState == .load {
                    LoadingView()
                } else if currentState == .success {
                    SuccessView()
                } else if currentState == .failure {
                    FailureView()
                } else {
                    LoadingView()
                }
                
                HStack {
                    Button("Reload") {
                        currentState = .load
                    }
                    Button("Success") {
                        currentState = .success
                    }
                    Button("Failure") {
                        currentState = .failure
                    }
                }
            }
        }
    }
}

struct EnumeratedStateView_Previews: PreviewProvider {
    static var previews: some View {
        EnumeratedStateView()
    }
}
