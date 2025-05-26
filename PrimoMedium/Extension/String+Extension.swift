//
//  String+Extension.swift
//  PrimoMedium
//
//  Created by Mew on 26/5/2568 BE.
//

import Foundation

extension String {
    func formatAPIDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // ensures consistent parsing
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMM yyyy" // e.g., "14 May 2025"
            outputFormatter.locale = Locale(identifier: "en_US")
            
            return outputFormatter.string(from: date)
        }
        
        return "nil"
    }
    
    func formatHTMLToString() -> NSAttributedString {
        
        let dataWithoutImage = self.replacingOccurrences(of: "<img[^>]+>", with: "", options: .regularExpression)
        
        guard let data = dataWithoutImage.description.data(using: .utf8) else {
            return NSAttributedString(string: "")
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString
        } else {
            return NSAttributedString(string: "")
        }
    }
}
