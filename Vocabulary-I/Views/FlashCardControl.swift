//
//  FlashCardControl.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 25/12/24.
//

import SwiftUI

struct FlashCardControl: View {
    var frontText: String? = "fron front front front front front front"
    var backText: String? = "back back"
    var count: String?
    var onTapCorrect: () -> Void
    var onTapMiss: () -> Void
    @Binding var showAnswer: Bool
    
    var body: some View {
        FlashCard(frontText: frontText, backText: backText, isFlipped: $showAnswer)
            .padding(.top, 100)
        Spacer()
        if showAnswer {
            VStack {
                HStack {
                    Button(action: {
                        onTapMiss()
                    }, label: {
                        Text("miss")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    })
                    
                    Button(action: {
                        onTapCorrect()
                    }, label: {
                        Text("correct")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    })
                    
                }
                .padding()
                Text("Reviewed: \(count ?? "0")")
                    .foregroundStyle(Color.gray)
            }
        }
    }
}













































#Preview {
    struct Wrapper: View {
        @State var isFlipped: Bool = false
        
        var body: some View {
            FlashCardControl(onTapCorrect: { }, onTapMiss: { }, showAnswer: $isFlipped)
        }
    }
    
    return Wrapper()
}
