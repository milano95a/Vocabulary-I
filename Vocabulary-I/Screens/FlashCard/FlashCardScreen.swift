//
//  QuizScreen.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import SwiftUI
import SwiftData

struct FlashCardScreen: View {
    var option: FlashCardOptions
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Vocabulary]
    @Query(sort: \Review.date, order: .reverse) private var reviews: [Review]
    @State private var randomItem: Vocabulary?
    @State private var showAnswer: Bool = false
    @State private var startTime: Date = .now
    
    var body: some View {
        VStack {            
            if randomItem != nil {
                switch option.language {
                case .ruToUz:
                    EmptyView()
                    
                case .uzToRu:
                    EmptyView()
                    
                case .ruToEng:
                    FlashCardControl(frontText: randomItem?.rus, backText: "\(randomItem?.eng ?? "")\n\n\(randomItem?.uz ?? "")", count: "\(randomItem?.ruToEngTotal ?? 0)", onTapCorrect: {
                        randomItem?.rusToEngCorrect.increment()
                        next()
                    }, onTapMiss: {
                        randomItem?.rusToEngMiss.increment()
                        next()
                    }, showAnswer: $showAnswer)
                    
                case .engToRu:
                    FlashCardControl(frontText: "\(randomItem?.eng ?? "")\n\n\(randomItem?.uz ?? "")", backText: randomItem?.rus, count: "\(randomItem?.engToRuTotal ?? 0)", onTapCorrect: {
                        randomItem?.engToRusCorrect.increment()
                        next()
                    }, onTapMiss: {
                        randomItem?.engToRusMiss.increment()
                        next()
                    }, showAnswer: $showAnswer)
                }
                
                if !showAnswer {
                    Text("Words: \(items.count)")
                        .foregroundStyle(Color.gray)
                }
            }
        }
        .onAppear {
            if randomItem == nil {
                randomItem = items.randomElement()
            }
        }
        .onDisappear() {
            let timeSpent = Date.now.timeIntervalSince(startTime)
            reviews.first?.numberOfSecondsReviewed += Int(timeSpent)
        }
        .toolbar {
            ToolbarItem {
                if randomItem != nil {
                    NavigationLink(destination: EditVocabularyScreen(item: randomItem!)) {
                        Label("Edit Item", systemImage: "square.and.pencil")
                    }
                }
            }
        }
    }
    
    private func next() {
        showAnswer = false
        randomItem = items.randomElement()
        reviews.first?.numberOfWordsReviewed += 1
    }
    
    init(option: FlashCardOptions) {
        self.option = option

        let correctMin = option.correctMin
        let correctMax = option.correctMax
        let missMin = option.missMin
        let missMax = option.missMax
        let totalMin = option.totalMin
        let totalMax = option.totalMax
        let fromDate = option.fromDate
        let toDate = option.toDate

        switch option.language {
            case .ruToEng:
                _items = Query(filter: #Predicate {
                    correctMin <= $0.rusToEngCorrect && $0.rusToEngCorrect <= correctMax &&
                    missMin <= $0.rusToEngMiss && $0.rusToEngMiss <= missMax &&
                    totalMin <= ($0.rusToEngMiss + $0.rusToEngCorrect) && ($0.rusToEngMiss + $0.rusToEngCorrect) <= totalMax &&
                    fromDate <= $0.date && $0.date <= toDate
                })
            case .engToRu:
                _items = Query(filter: #Predicate {
                    correctMin <= $0.engToRusCorrect && $0.engToRusCorrect <= correctMax &&
                    missMin <= $0.engToRusMiss && $0.engToRusMiss <= missMax &&
                    totalMin <= ($0.engToRusMiss + $0.engToRusCorrect) && ($0.engToRusMiss + $0.engToRusCorrect) <= totalMax &&
                    fromDate <= $0.date && $0.date <= toDate
                })
            case .ruToUz:
                _items = Query(filter: #Predicate {
                    correctMin <= $0.rusToUzCorrect && $0.rusToUzCorrect <= correctMax &&
                    missMin <= $0.rusToUzMiss && $0.rusToUzMiss <= missMax &&
                    totalMin <= ($0.rusToUzMiss + $0.rusToUzCorrect) && ($0.rusToUzMiss + $0.rusToUzCorrect) <= totalMax &&
                    fromDate <= $0.date && $0.date <= toDate
                })
            case .uzToRu:
                _items = Query(filter: #Predicate {
                    correctMin <= $0.uzToRusCorrect && $0.uzToRusCorrect <= correctMax &&
                    missMin <= $0.rusToUzMiss && $0.uzToRusMiss <= missMax &&
                    totalMin <= ($0.uzToRusMiss + $0.uzToRusCorrect) && ($0.uzToRusCorrect + $0.uzToRusCorrect) <= totalMax &&
                    fromDate <= $0.date && $0.date <= toDate
                })
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Vocabulary.self, configurations: config)
//        let example = Vocabulary(rus: "машина", uz: "avtomobil", eng: "car")
//        container.mainContext.insert(example)
//        return FlashCardScreen(option: .init(language: .engToRu, accuracyMin: 0, accuracyMax: 0, totalMin: 0, totalMax: 0, mistakeMin: 0, mistakeMax: 0, correctMin: 0, correctMax: 0))
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container")
//    }
//}

