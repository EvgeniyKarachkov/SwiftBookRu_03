//
//  ViewController.swift
//  SwiftBookRu_03
//
//  Created by Zodino BLR on 5/31/21.
//  Copyright © 2021 Zodino BLR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var buttonConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17)
        
        textView.backgroundColor = self.view.backgroundColor
        
        textView.layer.cornerRadius = 10
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: Notification.Name.UIKeyboardDidChangeFrame,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        
        //        self.view.endEditing(true)
        textView.resignFirstResponder()
    }
    
    
    
    @objc func updateTextView(notification: Notification) {
        
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIKeyboardIsLocalUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            textView.contentInset = UIEdgeInsets.zero
            
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - buttonConstraint.constant, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
}



extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
        textView.textColor = .gray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
}

