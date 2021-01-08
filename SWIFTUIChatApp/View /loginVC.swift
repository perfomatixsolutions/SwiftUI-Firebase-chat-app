//
//  login.swift
//  SWIFTUIChatApp
//
//  Created by Meera on 18/12/20.
//  Copyright © 2020 Meera. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

struct loginVC: View {
    var body: some View {
        Login( dataUser: userData())
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        loginVC()
    }
}


struct Login : View {
    
    @State var username  = ""
    @State var password  = ""
    @State var msg       = ""
    @State var alert     = false
    @State var selection : Int? = nil
    
    var logoImageWidth                  :CGFloat  = 250
    var logoImageTopAndBottomPadding    :CGFloat  = 20
    var textFieldCornerRad              :CGFloat  = 10
    var usrNameTextFieldBottomPadding   :CGFloat  = 15
    var textFieldOpacity                :Double   = 0.8
    var buttonPadding                   :CGFloat  = 80
    var buttonOpacity                   :Double   = 0.8
    var buttonCornerRadius              :CGFloat  = 12
    var textFieldsStackHorizontalPadding:CGFloat  = 6
    var buttonTopPadding                :CGFloat  = 45
    var buttonAllEdgePadding            :CGFloat  = 10
    var navgLinkTag                      = 1
    
    @State var dataUser: userData
    var body : some View{
        NavigationView{
            ZStack{
                Image("chat")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: logoImageWidth)
                        .padding(.vertical)
                        .padding(.top, -logoImageTopAndBottomPadding)
                        .padding(.bottom, logoImageTopAndBottomPadding)
                    
                    VStack(alignment: .leading){
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                Image(systemName: "person.circle").foregroundColor(Color.gray)
                                TextField("Enter Your Username", text: $username)
                                    .autocapitalization(.none)
                                    .foregroundColor(Color.gray)
                                
                            }.padding()
                                .background(Color.white.opacity(textFieldOpacity))
                                .cornerRadius(textFieldCornerRad)
                                .padding(.horizontal)
                            
                        }.padding(.bottom, usrNameTextFieldBottomPadding)
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                Image(systemName: "lock").foregroundColor(Color.gray)
                                SecureField("Enter Your Password", text: $password)
                                    .autocapitalization(.none)
                                    .foregroundColor(Color.gray)
                            }
                            .padding()
                            .background(Color.white.opacity(textFieldOpacity))
                            .cornerRadius(textFieldCornerRad)
                            .padding(.horizontal)
                        }
                        
                    }.padding(.horizontal, textFieldsStackHorizontalPadding)
                    
                    if username != ""{
                        NavigationLink(destination: reverseScroll( name: username), tag: navgLinkTag, selection: $selection){
                            
                            Button(action: {
                                print("login tapped")
                                self.selection = 1
                                
                                signInWithEmail(email: self.username, password: self.password) { (verified, status) in
                                    
                                    if !verified{
                                        
                                        self.msg = status
                                        self.alert.toggle()
                                    }
                                    else{
                                        print("verified user")
                                    }
                                }
                            }) {
                                
                                Text("SIGN IN")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .padding(.all, buttonAllEdgePadding)
                                    .padding([.leading, .trailing], buttonPadding)
                                    .background(Color.white).opacity(buttonOpacity)
                                    .cornerRadius(buttonCornerRadius)
                            }
                            .clipShape(Capsule())
                            .padding(.top, buttonTopPadding)
                            
                        }
                    }
                    Spacer(minLength: 0)
                }
                .padding()
                .alert(isPresented: $alert) {
                    Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                }
            }
        }
        
    }
}


private func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().signIn(withEmail: email, password: password) { (response, error) in
        
        if error != nil{
            
            completion(false,(error?.localizedDescription)!)
            return
        }
        print("SUCCESS")
        completion(true,(response?.user.email)!)
        let id = Auth.auth().currentUser?.uid
        UserDefaults.standard.set(id, forKey: "UserId")
    }
}



















