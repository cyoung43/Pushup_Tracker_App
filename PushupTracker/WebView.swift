//
//  WebView.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://hundredpushups.com")!))
    }
}

extension String {
    var url: URL {
        if let urlValue = URL(string: self) {
            return urlValue
        }
        
        fatalError("Unable to convert URL to string")
    }
}
