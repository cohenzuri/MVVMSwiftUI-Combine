//
//  HapticsManager.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/15/22.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    private let feedback = UINotificationFeedbackGenerator()
    private init() { }
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
        
    }
}

func hapric(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
