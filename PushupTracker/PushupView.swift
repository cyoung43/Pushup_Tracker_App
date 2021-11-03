//
//  PushupView.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import SwiftUI

struct PushupView: View {
    private struct HundredPushups {
        static let url = "https://hundredpushups.com".url
        static let pushupsForKyle = "https://bit.ly/PushupsForKyle".url
    }
    
    var body: some View {
        TabView {
            PushupRecordView(pushupViewModel: PushupViewModel())
                .tabItem {
                    Label("Pushups", systemImage: "list.dash")
                }
            WebView(request: URLRequest(url: HundredPushups.pushupsForKyle))
                .tabItem {
                    Label("Pushups for Kyle", systemImage: "person")
                }
            WebView(request: URLRequest(url: HundredPushups.url))
                .tabItem {
                    Label("HundredPushups", systemImage: "globe")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushupView()
    }
}
