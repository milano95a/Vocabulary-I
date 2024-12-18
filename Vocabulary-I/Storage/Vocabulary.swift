//
//  Item.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import Foundation
import SwiftData

@Model
final class Vocabulary {
    
    var rus: String
    var uz: String
    var eng: String
    var rusToUzCorrect: Int = 0
    var rusToUzMiss: Int = 0
    var rusToEngCorrect: Int = 0
    var rusToEngMiss: Int = 0
    var uzToRusCorrect: Int = 0
    var uzToRusMiss: Int = 0
    var engToRusCorrect: Int = 0
    var engToRusMiss: Int = 0
    var date: Date = Date.now
    
    init(rus: String, uz: String, eng: String) {
        self.rus = rus
        self.uz = uz
        self.eng = eng
    }
}

extension Vocabulary {
    var ruToUzTotal: Int {
        rusToUzCorrect + rusToUzMiss
    }
    var uzToRuTotal: Int {
        uzToRusCorrect + uzToRusMiss
    }
    var ruToEngTotal: Int {
        rusToEngCorrect + rusToEngMiss
    }
    var engToRuTotal: Int {
        engToRusCorrect + engToRusMiss
    }
    
    var ruToUzAccuracy: Int {
        if ruToUzTotal >= 5 {
            return Int(Double(rusToUzCorrect) / Double(ruToUzTotal) * 100)
        } else {
            return 0
        }
    }
    
    var uzToRuAccuracy: Int {
        if uzToRuTotal >= 5 {
            return Int(Double(uzToRusCorrect) / Double(uzToRuTotal) * 100)
        } else {
            return 0
        }
    }
    
    var engToRuAccuracy: Int {
        if engToRuTotal >= 5 {
            return Int(Double(engToRusCorrect) / Double(engToRuTotal) * 100)
        } else {
            return 0
        }
    }
    
    var ruToEngAccuracy: Int {
        if ruToEngTotal >= 5 {
            return Int(Double(rusToEngCorrect) / Double(ruToEngTotal) * 100)
        } else {
            return 0
        }
    }
}

@Model
final class Review {
    var date: Date = Date.now
    var numberOfWordsReviewed: Int = 0
    var numberOfSecondsReviewed: Int = 0
    
    init() { }
}

final class Vocabulary2 {
    var rusUz: Translation
    var rusEng: Translation
    
    internal init(rusUz: Translation, rusEng: Translation) {
        self.rusUz = rusUz
        self.rusEng = rusEng
    }
}

final class Translation {
    var word: String
    var translation: String
    var correct: Int = 0
    var miss: Int = 0
    
    init(word: String, translation: String) {
        self.word = word
        self.translation = translation
    }
}
