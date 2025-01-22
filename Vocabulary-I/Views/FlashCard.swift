//
//  FlashCard.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 13/12/24.
//

import SwiftUI

struct FlashCard: View {
    var frontText: String?
    var backText: String?
    @Binding var isFlipped: Bool
    
    init(frontText: String?, backText: String?, isFlipped: Binding<Bool>) {
        self.frontText = frontText
        self.backText = backText
        self._isFlipped = isFlipped
        self.text = frontText ?? "x"
        self.isFlippedNoAnimation = isFlipped.wrappedValue
    }
    
    @State private var isFlippedNoAnimation: Bool = false
    @State private var halfAnimation = false
    @State private var text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .scaleEffect(x: isFlippedNoAnimation ? -1 : 1, y: 1) // Flip the text horizontally
        }
        .padding()
        .frame(width: 340, height: 340)
        .background(Color(red: 243/255, green: 245/255, blue: 119/255))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .foregroundStyle(Color(red: 134/255, green: 136/255, blue: 62/255))
        .font(.title)
        .minimumScaleFactor(0.2)        
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),  // Rotate 180 degrees when flipped
            axis: (x: 0, y: 1, z: 0),       // Flip around the Y-axis (horizontal flip)
            perspective: 0.2                // Add some perspective to the rotation
        )
        .animation(.easeInOut(duration: 0.4), value: isFlipped)
        .onTapGesture {
            isFlipped.toggle()
        }
        .onChange(of: isFlipped) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // Action after the animation finishes
                isFlippedNoAnimation = isFlipped
                
                if isFlipped {
                    text = backText ?? "n/a"
                } else {
                    text = frontText ?? "n/a"
                }
            }
        }
    }
}

#Preview {
    struct Wrapper: View {
        @State private var isFlipped = false
        var body: some View {
            FlashCard(frontText: "front front front front front front", backText: "back back", isFlipped: $isFlipped)
        }
    }
    
    return Wrapper()
}
