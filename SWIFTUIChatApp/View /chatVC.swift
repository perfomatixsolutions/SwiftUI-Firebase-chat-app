//
//  chatVC.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 04/01/21.
//  Copyright © 2021 Meera. All rights reserved.
//

import SwiftUI
import Firebase
import Combine


struct reverseScroll: View{
    
    @ObservedObject var msg              = observer()
    @State var message                   = [""]
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var composedMessage           = ""
    var name                             :String = ""
    var myMsg                            :Bool = false
    var date                             = Date()
    let easeOutDuration                  :Double = 0.16
    let messageInsertIndex               = 0
    let textFieldMinHeight               :CGFloat = 30
    let scrollViwScaleX                  :CGFloat = 1
    let scrollViwScaleY                  :CGFloat = 1
    
    
    var body: some View{
        
        VStack{
            GeometryReader{
                reader in
                Image("wallimg")
                    .renderingMode(.original)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    VStack{
                        ForEach(self.msg.msgs) { i in
                            
                            if i.name == self.name
                            {
                                bubbleView(message: i.msg, myMsg: true, user: self.name)
                            }
                            else
                            {
                                bubbleView(message: i.msg, myMsg: false, user: i.senderName)
                            }
                        }
                    }.frame(width: reader.size.width)
                        .rotationEffect(.radians(.pi))
                        .scaleEffect(x: -self.scrollViwScaleX , y: self.scrollViwScaleY, anchor: .center)
                }
                .rotationEffect(.radians(.pi))
                .scaleEffect(x: -self.scrollViwScaleX , y: self.scrollViwScaleY, anchor: .center)
            }
            
            HStack {
                
                TextField("Message...", text: self.$composedMessage).frame(minHeight: CGFloat(textFieldMinHeight)).textFieldStyle(RoundedBorderTextFieldStyle())
                
                if self.composedMessage != ""{
                    
                    Button(action:{
                        let myMessage = self.composedMessage
                        self.message.insert(myMessage, at: self.messageInsertIndex)
                        self.addMessage(msg: myMessage, user: self.name, date: self.date)
                        self.composedMessage = ""
                        
                    }) {
                        Text("Send")
                    }
                }
            }.padding()
                
                .padding(.bottom, self.keyboard.currentHeight)
                .edgesIgnoringSafeArea(.bottom)
                .animation(.easeOut(duration: easeOutDuration))
        }
    }
    
   private func addMessage(msg: String, user: String, date: Date){
        
        let db = Firestore.firestore()
        db.collection("messageCollection").addDocument(data: ["msg": msg, "name": user, "date": Date()]) { (err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            print("SUCCESS")
        }
    }
}




struct chat_Previews: PreviewProvider {
    static var previews: some View {
        reverseScroll()
    }
}




