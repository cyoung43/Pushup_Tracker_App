//
//  EditableText.swift
//  PushupTracker
//
//  Created by Chris Young on 11/17/21.
//

import SwiftUI

extension TextAlignment {
    var alignment: Alignment {
        self == .leading ? .leading : .trailing
    }
}

struct EditableText: View {
    var text: String = ""
    var isEditing: Bool
    var textAlignment: TextAlignment
    var onChanged: (String) -> Void
    
    @State private var editableText: String = ""
    
    var body: some View {
        ZStack(alignment: textAlignment.alignment) {
            TextField(text, text: $editableText, onEditingChanged: { began in
                callOnChangedIfChanged()
            })
                .multilineTextAlignment(textAlignment)
                .opacity(isEditing ? 1 : 0)
                .disabled(!isEditing)
            
            if !isEditing {
                Text(text)
                    .multilineTextAlignment(textAlignment)
                    .opacity(isEditing ? 0 : 1)
                    .onAppear {
                        callOnChangedIfChanged()
                    }
            }
        }
        .onAppear { editableText = text }
    }
    
    func callOnChangedIfChanged() {
        if editableText != text {
            onChanged(editableText)
        }
    }
}
