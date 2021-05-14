//
//  Helper.swift
//  Dictation
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import Foundation

func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any], let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
        
    } else {
        return Date()
    }
}
