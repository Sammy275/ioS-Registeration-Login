//
//  UILabelExt.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import UIKit

extension UILabel {
    func showWarningLabel(text: String) {
        textColor = .red
        isHidden = false
        self.text = text
    }
    
    func showSuccessLabel(text: String) {
        textColor = .systemGreen
        isHidden = false
        self.text = text
    }
    
    @objc func hideLabel() {
        isHidden = true
        text = ""
    }
    
    func hideLabelAfter(seconds: Double) {
        Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(hideLabel), userInfo: nil, repeats: false)
    }
}
