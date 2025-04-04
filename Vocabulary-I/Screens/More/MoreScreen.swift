//
//  MoreScreen.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import SwiftUI
import SwiftData
import Charts

struct MoreScreen: View {
    @Query private var items: [Vocabulary]
    @Query(sort: \Review.date) private var reviews: [Review]
    
    var body: some View {
        Form {
            
            HStack {
                Text("Vocabulary count")
                Spacer()
                Text("\(items.count)")
            }
            
            Section("ru - eng accuracy") {
                let stat = ruToEngAccuracy()
                
                HStack {
                    Chart {
                        ForEach(stat) { item in
                            SectorMark(angle: .value("Level", item.value))
                                .foregroundStyle(item.color)
                        }
                    }
                }
                .padding(.vertical, 16)
                
                VStack {
                    HStack {
                        HStack {
                            Text("Level")
                        }
                        .frame(maxWidth: .infinity)
                        Text("Percentage")
                            .frame(maxWidth: .infinity)
                        Text("Count")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.green)
                            Text("Mastered")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[0].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[0].value)")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.orange)
                            Text("Learned")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[1].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[1].value)")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.red)
                            Text("New")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[2].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[2].value)")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Section("eng - ru accuracy") {
                let stat = engToRuAccuracy()
                
                HStack {
                    Chart {
                        ForEach(stat) { item in
                            SectorMark(angle: .value("Level", item.value))
                                .foregroundStyle(item.color)
                        }
                    }
                }
                .padding(.vertical, 16)
                
                VStack {
                    HStack {
                        HStack {
                            Text("Level")
                        }
                        .frame(maxWidth: .infinity)
                        Text("Percentage")
                            .frame(maxWidth: .infinity)
                        Text("Count")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.green)
                            Text("Mastered")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[0].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[0].value)")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.orange)
                            Text("Learned")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[1].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[1].value)")
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(Color.red)
                            Text("New")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(Int(Double(stat[2].value) / Double(items.count) * 100))%")
                            .frame(maxWidth: .infinity)
                        Text("\(stat[2].value)")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Section("Words added") {
                Chart {
                    ForEach(numOfWordsAddedLast7Days()) { item in
                        BarMark(x: .value("Day", item.title), y: .value("Total Count", item.value))
                    }
                }
                .padding(.vertical, 16)
            }
            
            Section("Review count") {
                Chart {
                    ForEach(numOfReviewedWordsLast7Days()) { item in
                        BarMark(x: .value("Day", item.title), y: .value("Total Count", item.value))
                    }
                }
                .padding(.vertical, 16)
            }

            Section("review time") {
                Chart {
                    ForEach(numOfMinutesSpentLast7Days()) { item in
                        BarMark(x: .value("Day", item.title), y: .value("Total Count", item.value))
                    }
                }
                .padding(.vertical, 16)
            }
                        
            Section("Parser") {
                NavigationLink(destination: ParserScreen()) {
                    Text("Parser")
                }
            }
            
            Section("Reset") {
                Button("Reset unlearned to 0") {
                    for index in items.indices {
                        if items[index].rusToEngMiss > 0 {
                            items[index].rusToEngCorrect = 0
                            items[index].rusToEngMiss = 0
                        }
                        
                        if items[index].engToRusMiss > 0 {
                            items[index].engToRusCorrect = 0
                            items[index].engToRusMiss = 0
                        }
                    }
                }
                
                Button("Reset everything to 5") {
                    for index in items.indices {
                        items[index].rusToEngCorrect = 5
                        items[index].rusToEngMiss = 0
                        items[index].engToRusCorrect = 5
                        items[index].engToRusMiss = 0
                        items[index].rusToUzCorrect = 5
                        items[index].rusToUzMiss = 0
                        items[index].uzToRusCorrect = 5
                        items[index].uzToRusMiss = 0
                    }
                }
            }
                        
            Section("Processing") {
                Button("to lowercase") {
                    toLowercase()
                }
                Button("remove dot (.)") {
                    removeDots()
                }
                Button("remove space at the beginning") {
                    removeSpace()
                }
            }
        }
        .navigationTitle("More")
    }
    
    struct ChartItem: Identifiable {
        var id = UUID()
        var title: String
        var value: Int
    }
    
    struct ChartItem2: Identifiable {
        var id = UUID()
        var title: String
        var value: Int
        var color: Color
    }
    
    func toLowercase() {
        for index in items.indices {
            items[index].eng = items[index].eng.lowercased()
            items[index].rus = items[index].rus.lowercased()
            items[index].uz = items[index].uz.lowercased()
        }
    }
    
    func removeDots() {
        for index in items.indices {
            items[index].eng = items[index].eng.replacingOccurrences(of: ".", with: "")
            items[index].rus = items[index].rus.replacingOccurrences(of: ".", with: "")
            items[index].uz = items[index].uz.replacingOccurrences(of: ".", with: "")
        }
    }
    
    func removeSpace() {
        for index in items.indices {
            items[index].eng = items[index].eng.removeWhiteSpacesAtTheBeginning
            items[index].rus = items[index].rus.removeWhiteSpacesAtTheBeginning
            items[index].uz = items[index].uz.removeWhiteSpacesAtTheBeginning
        }
    }
    
    func ruToEngAccuracy() -> [ChartItem2] {
        var numOfVocabularyWithAccuracyEqualOrMoreThan80 = 0
        var numOfVocabularyWithAccuracyEqualOrMoreLess60 = 0
        var numOfVocabularyWithAccuracyLessThan60 = 0
        
        for item in items {
            if item.ruToEngAccuracy >= 80 {
                numOfVocabularyWithAccuracyEqualOrMoreThan80 += 1
            } else if item.ruToEngAccuracy >= 60 {
                numOfVocabularyWithAccuracyEqualOrMoreLess60 += 1
            } else {
                numOfVocabularyWithAccuracyLessThan60 += 1
            }
        }
        return [
            .init(title: "80%", value: numOfVocabularyWithAccuracyEqualOrMoreThan80, color: .green),
            .init(title: "60%", value: numOfVocabularyWithAccuracyEqualOrMoreLess60, color: .orange),
            .init(title: "0%", value: numOfVocabularyWithAccuracyLessThan60, color: .red),
        ]
    }
    
    func engToRuAccuracy() -> [ChartItem2] {
        var numOfVocabularyWithAccuracyEqualOrMoreThan80 = 0
        var numOfVocabularyWithAccuracyEqualOrMoreLess60 = 0
        var numOfVocabularyWithAccuracyLessThan60 = 0
        
        for item in items {
            if item.engToRuAccuracy >= 90 {
                numOfVocabularyWithAccuracyEqualOrMoreThan80 += 1
            } else if item.engToRuAccuracy >= 60 {
                numOfVocabularyWithAccuracyEqualOrMoreLess60 += 1
            } else {
                numOfVocabularyWithAccuracyLessThan60 += 1
            }
        }
        return [
            .init(title: "80%", value: numOfVocabularyWithAccuracyEqualOrMoreThan80, color: .green),
            .init(title: "60%", value: numOfVocabularyWithAccuracyEqualOrMoreLess60, color: .orange),
            .init(title: "0%", value: numOfVocabularyWithAccuracyLessThan60, color: .red),
        ]
    }
    
    func numOfWordsAddedLast7Days() -> [ChartItem] {
        var chartItems = [ChartItem]()
        
        for days in stride(from: 6, through: 0, by: -1) {
            if let date = Calendar.current.date(byAdding: .day, value: -days, to: .now) {
                let formatter = DateFormatter()
                formatter.dateFormat = "E"
                let shortDayOfWeek = formatter.string(from: date)
                let count = items.filter { Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }.count
                chartItems.append(.init(title: shortDayOfWeek, value: count))
            }
        }
        
        return chartItems
    }
    
    func numOfReviewedWordsLast7Days() -> [ChartItem] {
        var chartItems = [ChartItem]()
        
        for days in stride(from: 6, through: 0, by: -1) {
            if let date = Calendar.current.date(byAdding: .day, value: -days, to: .now) {
                let formatter = DateFormatter()
                formatter.dateFormat = "E"
                let shortDayOfWeek = formatter.string(from: date)
                if let item = reviews.filter({ Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }).first {
                    chartItems.append(.init(title: shortDayOfWeek, value: item.numberOfWordsReviewed))
                } else {
                    chartItems.append(.init(title: shortDayOfWeek, value: 0))
                }
            }
        }
        
        return chartItems
    }
    
    func numOfMinutesSpentLast7Days() -> [ChartItem] {
        var chartItems = [ChartItem]()
        
        for days in stride(from: 6, through: 0, by: -1) {
            if let date = Calendar.current.date(byAdding: .day, value: -days, to: .now) {
                let formatter = DateFormatter()
                formatter.dateFormat = "E"
                let shortDayOfWeek = formatter.string(from: date)
                if let item = reviews.filter({ Calendar.current.isDate($0.date, equalTo: date, toGranularity: .day) }).first {
                    chartItems.append(.init(title: shortDayOfWeek, value: item.numberOfSecondsReviewed / 60))
                } else {
                    chartItems.append(.init(title: shortDayOfWeek, value: 0))
                }
            }
        }
        
        return chartItems
    }
}


//#Preview {
//    MoreScreen()
//}
