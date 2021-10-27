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
    }
    
    var body: some View {
        TabView {
            PushupRecordView(pushupViewModel: PushupViewModel())
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Pushups")
                }
            WebView(request: URLRequest(url: HundredPushups.url))
                .tabItem {
                    Image(systemName: "globe")
                    Text("HundredPushups.com")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushupView()
    }
}
