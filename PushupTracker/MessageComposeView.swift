//
//  MessageComposeView.swift
//  PushupTracker
//
//  Created by Chris Young on 11/3/21.
//

import SwiftUI
import MessageUI

struct MessageComposeView: UIViewControllerRepresentable {
    typealias CompletionHandler = (_ messageSent: Bool) -> Void
    
    static var canSendText: Bool {
        MFMessageComposeViewController.canSendText()
    }
    
    let recipients: [String]?
    let body: String?
    let completion: CompletionHandler?
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            return UIHostingController(rootView: messagesUnavailableView)
        }
        
        let controller = MFMessageComposeViewController()
        
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Ignore
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let completion: CompletionHandler?
        
        init(completion: CompletionHandler?) {
            self.completion = completion
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
    
    var messagesUnavailableView: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 64))
                .foregroundColor(.red)
            Text("Text messages unavailable")
                .font(.system(size: 24))
        }
    }
}
