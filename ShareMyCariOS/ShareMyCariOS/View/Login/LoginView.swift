//
//  LoginView.swift
//  ShareMyCariOS
//
//  Created by Bas Buijsen on 27/01/2022.
//

import SwiftUI

struct LoginView: View {
    @Binding var menu : MenuItem
    
    @State var email : String = ""
    @State var password : String = ""
    
    @State var showError : Bool = false
    
    @State var showLoader : Bool = false
    
    var body: some View {
        VStack{
            LoadingView(isShowing: $showLoader){
                VStack{
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 50)
                    
                    Text("Email")
                    TextField("john@doe.nl", text: $email)
                        .keyboardType(.emailAddress)
                        .multilineTextAlignment(.center)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Secondary"), lineWidth: 1)
                        )
                    
                    Text("Wachtwoord")
                    SecureField("wachtwoord", text: $password)
                        .multilineTextAlignment(.center)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Secondary"), lineWidth: 1)
                        )
                    
                    Button("Inloggen", action: {
                        Task{
                            await login()
                        }
                    }).padding(10)
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Secondary"), lineWidth: 1)
                    ).background(RoundedRectangle(cornerRadius: 10).fill(Color("Secondary")))
                    
                    Button("Nog geen account? Registreer hier", action: {
                        menu = .register
                    }).padding(10)
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Secondary"), lineWidth: 1)
                    ).background(RoundedRectangle(cornerRadius: 10).fill(Color("Secondary")))
                    
                    Spacer()
                }.onAppear(perform: {
                    startLogin()
                }).padding(.horizontal, 50)
                    .alert(isPresented: $showError){
                        Alert(title: Text("Inloggen mislukt"), message: Text("Controleer uw email en wachtwoord of maak een account aan als u die nog niet heeft"), dismissButton: Alert.Button.default(Text("Oke"), action: {
                            print("hi")
                        }))
                    }
            }
        }
        
    }
    
    func startLogin() {
        let token : String = getTokenFromChain()
        if token != " " {
            menu = .home
        }
    }
    
    func login() async {
        do{
            showLoader = true
            let result = try await apiLogin(email: email, password: password)
            if result != nil {
                menu = .home
            } else {
                showError = true
            }
        } catch let error {
            print(error)
        }
    }
}
