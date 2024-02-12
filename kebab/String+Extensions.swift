//
//  String+Extensions.swift
//  JustSomeApp
//
//  Created by jefferson on 30.01.24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
