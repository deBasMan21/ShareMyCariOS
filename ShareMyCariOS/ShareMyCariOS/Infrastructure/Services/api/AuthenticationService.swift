//
//  AuthenticationService.swift
//  ShareMyCariOS
//
//  Created by Bas Buijsen on 28/01/2022.
//

import Foundation
import Firebase

func apiLogin(email : String, password : String) async throws -> User? {
    let fbToken = Messaging.messaging().fcmToken
    
    let json : [String : Any] = ["email" : email, "password": password, "fbtoken": fbToken ?? "undefined"]
    
    let data = try await apiCall(url: "\(apiURL)/authentication/login", body: json, method: "POST", obj: AuthenticationWrapper(result: AuthenticationBody(token: "", expireDate: "", user: nil)), authorized: false)
    
    if data != nil {
        saveTokenToChain(input: data!.result.token)
        saveUserIdToChain(id: data!.result.user!.id)
    }

    return data?.result.user
}

func apiRegister(email: String, password : String, name : String, phoneNumber : String) async throws -> User? {
    let fbToken = Messaging.messaging().fcmToken
    
    let json : [String : Any] = ["email" : email, "password": password, "name": name, "phoneNumber": phoneNumber, "fbtoken": fbToken ?? "undefined"]
    
    let data = try await apiCall(url: "\(apiURL)/authentication/register", body: json, method: "POST", obj: AuthenticationWrapper(result: AuthenticationBody(token: "", expireDate: "", user: nil)), authorized: false)
    
    if data != nil {
        saveTokenToChain(input: data!.result.token)
        saveUserIdToChain(id: data!.result.user!.id)
    }
    
    return data?.result.user
}