//
//  PushupsForKyleView.swift
//  PushupTracker
//
//  Created by New User on 11/17/21.
//

import SwiftUI

struct PushupsForKyleView: View {
    var externalUrl: URL
    
    var body: some View {
        NavigationView {
            Form {
                missionBody
                
                Section(header: Text("Learn More")) {
                    Link(destination: externalUrl) {
                        Label("Go to Facebook Page", systemImage: "link.circle.fill")
                    }
                }
            }
            .navigationBarTitle("Pushups for Kyle")
        }
    }
    
    var missionBody: some View {
        Section(header: Text("The Mission and Goal")) {
            Text("""
                Do 100,000 pushups for Kyle before November 10th. \
            Contact Richard at (richlamx@hotmail.com) or 801-360-1066.
            """)
                
        }
    }
}

struct PushupsForKyleView_Previews: PreviewProvider {
    static var previews: some View {
        PushupsForKyleView(externalUrl: "https://bit.ly/PushupsForKyle".url)
    }
}
