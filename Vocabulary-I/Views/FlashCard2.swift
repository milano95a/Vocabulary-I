//
//  FlippingCard.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 22/01/25.
//

import SwiftUI

struct FlashCard2: View {
    
    @State private var animate3d = false
    var frontText: String?
    var backText: String?
    @Binding var isFlipped: Bool
    
    var body: some View {
        ZStack() {
            Card(text: frontText).opacity(isFlipped ? 0.0 : 1.0)
            Card(text: backText).opacity(isFlipped ? 1.0 : 0.0)
        }
        .modifier(FlipEffect(flipped: $isFlipped, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.2)) {
                self.animate3d.toggle()
            }
        }
    }
}

struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    var zoom: CGFloat = 0.6
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        
        let tweakedAngle = flipped ? -180 + angle : angle
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height) * zoom
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct Card : View {
    var text: String?
    
    var body: some View {
        Text(text ?? "n/a")
            .padding()
            .frame(width: 340, height: 340)
            .background(Color(red: 243/255, green: 245/255, blue: 119/255))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundStyle(Color(red: 134/255, green: 136/255, blue: 62/255))
            .font(.title)
            .minimumScaleFactor(0.2)
    }
}

#Preview {
    struct Wrapper: View {
        @State var isFlipped = false
        
        var body: some View {
            FlashCard2(
                       frontText: "One thing is for sure – a sheep is not a creature of the air.",
                       backText: "If you know you have an unpleasant nature and dislike people, this is no obstacle to work.",
                       isFlipped: $isFlipped)
        }
    }
    
    return Wrapper()
}
