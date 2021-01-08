//
//  chatMessageVM.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 04/01/21.
//  Copyright © 2021 Meera. All rights reserved.
//

import Foundation
import Combine
import Firebase

class observer: ObservableObject{
    
    @Published var msgs = [dataType]()
    init()
        
    {
        
        let db = Firestore.firestore()
        db.collection("messageCollection").order(by: "date", descending: false).addSnapshotListener { (snap, error) in
            if error != nil
            {
                print((error?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    let name = i.document.get("name") as! String
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    self.msgs.append(dataType(id: id, name: name, msg: msg))
                }
            }
        }
    }
}

