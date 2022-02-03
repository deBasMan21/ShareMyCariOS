//
//  GeneralPageLayout.swift
//  ShareMyCariOS
//
//  Created by Bas Buijsen on 27/01/2022.
//

import SwiftUI

struct GeneralPageLayout: View {
    @Binding var menu : MenuItem
    @State var animationTest = false
    
    var body: some View {
        VStack{
            NavigationView{
                if menu == .home {
                    HomeView(menu: $menu)
                } else if menu == .rides {
                    RidesView()
                } else if menu == .settings {
                    SettingsView(menu : $menu)
                } else if menu == .locations {
                    LocationsView()
                }
                
                Spacer()
            }

            Spacer()
            
            HStack{
                Spacer()
                
                VStack{
                    Image("HomeIcon").onTapGesture {
                        withAnimation(.easeInOut){
                            menu = .home
                        }
                    }
                    
                    if menu == .home{
                        Divider()
                            .frame(width: 50)
                            .transition(.offset(x: 0, y: 50))
                    }
                }
                
                Spacer()
                
                VStack{
                    Image("CalendarIcon").onTapGesture {
                        withAnimation(.easeInOut){
                            menu = .rides
                        }
                    }
                    
                    if menu == .rides{
                        Divider()
                            .frame(width: 50)
                            .transition(.offset(x: 0, y: 50))
                    }
                }
                
                Spacer()
                
                VStack{
                    Image("MapIcon").onTapGesture {
                        withAnimation(.easeInOut){
                            menu = .locations
                        }
                    }
                    
                    if menu == .locations{
                        Divider()
                            .frame(width: 50)
                            .transition(.offset(x: 0, y: 50))
                    }
                }
                
                Spacer()
                

                VStack{
                    Image("SettingsIcon").onTapGesture {
                        withAnimation(.easeInOut){
                            menu = .settings
                        }
                    }
                    
                    if menu == .settings{
                        Divider()
                            .frame(width: 50)
                            .transition(.offset(x: 0, y: 50))
                    }
                }

                Spacer()
            }.padding(20)
        }
    }
}
