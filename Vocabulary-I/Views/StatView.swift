//
//  StatView.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import SwiftUI

struct StatView: View {
    var title: String
    var correct: Int
    var miss: Int
    
    var accuracy: Int {
        if isNew {
            return 0
        }
        return Int(Double(correct) / Double(total) * 100)
    }
    
    var total: Int {
        correct + miss
    }
    
    var accuracyColor: Color {
        if isNew {
            return Color.gray
        }
        
        if accuracy <= 60 {
            return Color.red
        } else if accuracy < 80 {
            return Color.orange
        } else {
            return Color.green
        }
    }
    
    var isNew: Bool {
        return total < 5
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .frame(width: 100, alignment: .leading)
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "checkmark.square")
                        .foregroundStyle(Color.green)
                    Text("\(correct)")
                        .foregroundStyle(Color.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    Image(systemName: "x.square")
                        .foregroundStyle(Color.red)
                    Text("\(miss)")
                        .foregroundStyle(Color.red)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 0) {
                    Image(systemName: "circle.circle")
                        .foregroundStyle(accuracyColor)
                    Text("\(accuracy)%")
                        .foregroundStyle(accuracyColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    StatView(title: "Rus - Uz", correct: 200, miss: 100)
}
