//
//  ListOfVocabularyView.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 14/12/24.
//

import SwiftUI
import SwiftData

struct ListOfVocabularyView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Vocabulary.date, order: .reverse) private var items: [Vocabulary]
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: DetailVocabularyScreen(item: item)) {
                    VStack(alignment: .leading) {
                        Text(item.rus)
                        Text(item.eng)
                        Text(item.uz)
                            .padding(.bottom, 8)
                        StatView(title: "ru - eng", correct: item.rusToEngCorrect, miss: item.rusToEngMiss)
                        StatView(title: "eng - ru", correct: item.engToRusCorrect, miss: item.engToRusMiss)
                    }
                }
            }
            .onDelete(perform: deleteItems)
            
        }
    }
    
    init(sort: SortDescriptor<Vocabulary>, searchString: String) {
        if searchString.isEmpty {
            _items = Query(filter: #Predicate {
                return $0.rusToEngCorrect >= 0
            }, sort: [sort])
        } else if searchString.lowercased().starts(with: "m:") {
            if let minMissStr = searchString.components(separatedBy: ":").last, let minMiss = Int(minMissStr) {
                _items = Query(filter: #Predicate {
                    return $0.rusToEngMiss >= minMiss || $0.engToRusMiss >= minMiss || $0.rusToUzMiss >= minMiss || $0.uzToRusMiss >= minMiss
                }, sort: [sort])
            }
        } else {
            _items = Query(filter: #Predicate {
                return $0.rus.localizedStandardContains(searchString) || $0.eng.localizedStandardContains(searchString) || $0.uz.localizedStandardContains(searchString)
            }, sort: [sort])
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

//#Preview {
//    ListOfVocabularyView()
//}
