//
//  String+Ext.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 17/01/25.
//

import Foundation

extension String {
    var removeWhiteSpacesAtTheBeginning: String {
        if let firstNonWhitespaceIndex = self.firstIndex(where: { !$0.isWhitespace }) {
            let trimmedString = self[firstNonWhitespaceIndex...]
            return String(trimmedString)
        } else {
            return ""
        }
    }
}
