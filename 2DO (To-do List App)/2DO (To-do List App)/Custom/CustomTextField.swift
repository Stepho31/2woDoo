//
//  CustomTextField.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/9/24.
//

import Foundation
import SwiftUI

struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var placeholderColor: UIColor
    var textColor: UIColor
    var onCommit: (() -> Void)?
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        textField.textColor = textColor
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        if text.isEmpty && !uiView.isFirstResponder {
            uiView.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                              attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        } else {
            uiView.attributedPlaceholder = nil
        }
    }
    
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField
        
        init(_ textField: CustomTextField) {
            self.parent = textField
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            parent.onCommit?()
            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
