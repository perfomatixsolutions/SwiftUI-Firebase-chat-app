//
//  keyBoardHandler.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 04/01/21.
//  Copyright © 2021 Meera. All rights reserved.
//

import Foundation
import SwiftUI

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}




public func splitAtFirst(str: String, delimiter: String) -> (String)? {
   guard let lowerIndex = (str.range(of: delimiter)?.lowerBound) else { return nil }
   let firstPart: String = .init(str.prefix(upTo: lowerIndex))
   return firstPart
}