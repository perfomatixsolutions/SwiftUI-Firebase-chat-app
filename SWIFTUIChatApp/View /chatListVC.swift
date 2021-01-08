//
//  chatListVC.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 16/12/20.
//  Copyright © 2020 Meera. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

//MARK: TO DO


struct chatListVC: View {
    var body: some View {
        Home()
    }
}

struct chatListVC_Previews: PreviewProvider {
    static var previews: some View {
        chatListVC()
    }
}

struct Home: View {
    var body: some View{
        
        ZStack{
            VStack{
                TopView()
                chatView()
                
            }
        }
    }
}

struct TopView: View {
    var body: some View{
        
        
        VStack(spacing: 6){
            HStack{
                Text("Messages")
                    
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                Button(action: {
                    
                }) {Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .frame(width: 25, height: 22, alignment: .trailing)
                    .foregroundColor(.gray)
                }
            }.padding()
        }
    }
}

struct chatView: View {
    @ObservedObject var datas = mainClass()
    
    var body: some View{
        NavigationView{
            List(datas.userData){i in
                chatCellView( name: i.name)
                
            }
        }
    }
}

struct chatCellView: View {
    var name: String = ""
    var email: String = ""
    var body: some View{
        
        HStack( spacing: 12){
            
            VStack(alignment: .leading, spacing: 12){
                Text(name)
                Text(email)
            }
            Spacer(minLength: 0)
            
            VStack{
                Spacer()
            }
        }.padding(.vertical)
    }
}


struct recent : Identifiable {
    
    var id : String
    var msg : String
}

struct user: Identifiable{
    var id: String
    var name: String
}

class mainClass: ObservableObject{
    
    @Published var userData = [user]()
    let uid = "heNcrHG5INTp0Ed8s2rvLNu7QfZ2"
    
    init() {
        let db = Firestore.firestore()
        db.collection("users").addSnapshotListener { (resp, error) in
            
            
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
            print("hei")
            
            for i in resp!.documentChanges{
                
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                // let email = i.document.get("email") as! String
                
                
                self.userData.append(user(id: id, name: name))
                
            }
        }
        
        
    }
}




