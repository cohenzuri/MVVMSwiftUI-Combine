//
//  SwiftUIWithMVVMHomeAssistantExmpleApp.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/3/22.
//

import SwiftUI

@main
struct SwiftUIWithMVVMHomeAssistantExmpleApp: App {
    var body: some Scene {
        
        WindowGroup {
            
            TabView {
                
                UsersListView()
                    .tabItem {
                        Symbols.home
                    }
                    
                    .accentColor(Color.white)
                
                UsersListView()
                    .tabItem {
                        Symbols.search
                    }
                
                
                UsersListView()
                    .tabItem {
                        Symbols.profile
                    }
                
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }

            }.accentColor(.white)

        }
    }
}
