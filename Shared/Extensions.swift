//
//  Extensions.swift
//  Dictation
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import Foundation

extension Date {
    
    func toString(dateFormat format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
