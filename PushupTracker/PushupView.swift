//
//  PushupView.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import SwiftUI

struct PushupView: View {
    private struct ConstURL {
        static let url = "https://hundredpushups.com".url
        static let pushupsForKyle = "https://bit.ly/PushupsForKyle".url
    }
    
    var body: some View {
        TabView {
            PushupRecordView(pushupViewModel: PushupViewModel())
                .tabItem {
                    Label("Pushups", systemImage: "list.dash")
                }
            PushupsForKyleView(externalUrl: ConstURL.pushupsForKyle)
                .tabItem {
                    Label("Pushups for Kyle", systemImage: "person")
                }
            WebView(request: URLRequest(url: ConstURL.url))
                .tabItem {
                    Label("HundredPushups", systemImage: "globe")
                }
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushupView()
    }
}
