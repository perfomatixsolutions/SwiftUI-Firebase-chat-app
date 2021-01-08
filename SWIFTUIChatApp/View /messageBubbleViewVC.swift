//
//  messageBubbleViewVC.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 04/01/21.
//  Copyright © 2021 Meera. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct bubbleView: View {
    let message                         :String
    let myMsg                           :Bool
    let user                            :String
    let MessageTextCornerRadius         :CGFloat = 10
    let messageTextPadding              :CGFloat = 8
    let userFontSize                    :CGFloat = 12
    let userNamePadding                 :CGFloat = 20
    let msgViewSpacing                  :CGFloat = 20
        
    var body: some View{
        HStack{
            
            if message == ""{
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .clipShape(Rectangle())
                    .cornerRadius(MessageTextCornerRadius)
                    .padding(messageTextPadding)
                
            }
            
            if myMsg{
                Spacer()
                VStack(alignment: .leading, spacing: msgViewSpacing){
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .clipShape(bubbleViewShape(myChat: true))
                        .cornerRadius(MessageTextCornerRadius)
                        .padding(messageTextPadding)
                }
            }
                
            else{
                VStack(alignment: .leading){
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .clipShape(bubbleViewShape(myChat: false))
                        .cornerRadius(MessageTextCornerRadius)
                        .padding(messageTextPadding)
                    
                    Text(user)
                        .font(.system(size: userFontSize))
                        .foregroundColor(Color.white)
                        .padding(.leading, userNamePadding)
                }
                Spacer()
            }
            
        }
    }
}



