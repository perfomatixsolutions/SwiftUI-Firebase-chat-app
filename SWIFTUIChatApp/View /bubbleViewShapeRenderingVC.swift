//
//  bubbleViewShapeVC.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 04/01/21.
//  Copyright © 2021 Meera. All rights reserved.
//

import Foundation
import SwiftUI

//bubbleShape rendering
struct bubbleViewShape: Shape {
    var myChat: Bool = false
    var bubbleViewCornerRadiWidthAndHeight: CGFloat = 20
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, myChat ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: bubbleViewCornerRadiWidthAndHeight, height: bubbleViewCornerRadiWidthAndHeight))
        
        return Path(path.cgPath)
    }
    
}
