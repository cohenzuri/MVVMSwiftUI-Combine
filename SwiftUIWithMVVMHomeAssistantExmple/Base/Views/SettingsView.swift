//
//  SettingsView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/15/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var  isHapticsEnabled: Bool = true
    
    var body: some View {
        
        NavigationView {
            Form{
                haptics
            }
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    
    var haptics: some View {
        Toggle("Enable haptics", isOn: $isHapticsEnabled)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
