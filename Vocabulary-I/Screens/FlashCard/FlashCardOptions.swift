//
//  FlashCardOptions.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import Foundation

struct FlashCardOptions {
    var language: FlashCardOptionsLanguage
    
    var accuracyMin: Int
    var accuracyMax: Int
    var totalMin: Int
    var totalMax: Int
    var missMin: Int
    var missMax: Int
    var correctMin: Int
    var correctMax: Int
    var fromDate: Date
    var toDate: Date
}

enum FlashCardOptionsLanguage: CaseIterable, Identifiable {
    
    var id: String {
        self.title
    }
    
    case ruToEng
    case engToRu
    
    var title: String {
        switch self {
            case .ruToEng: return "ru - eng"
            case .engToRu: return "eng - ru"
        }
    }
}

