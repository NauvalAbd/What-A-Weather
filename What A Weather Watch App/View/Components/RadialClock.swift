//
//  RadialLayout.swift
//  What A Weather Watch App
//
//  Created by mac.bernanda on 27/05/24.
//

import SwiftUI

struct RadialLayout: Layout {
    var radius: CGFloat
    var angle: Double
    @Binding var offset: Double
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
        let maxHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        let diameter = 2 * radius + max(maxWidth, maxHeight)
        return CGSize(width: diameter, height: diameter)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            var point = CGPoint(x: 0, y: -radius)
                .applying(CGAffineTransform(rotationAngle: angle * Double(index) + offset))
            
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct ClockRadial: View {
    @Binding var dragAmount : CGSize
    @Binding var offset : Double
    @Binding var initialOffset : Double
    
    var body: some View {
        ZStack {
            Image("PinClockOrange")
                .padding(.bottom, 130)
                .padding(.leading, -105)
                .rotationEffect(.degrees(13.0))
                .scaleEffect(CGSize(width: 1.1, height: 1.1))
            
            // Add a circular path as the background
            Circle()
                .stroke(Color.wawBlack20, lineWidth: 45)
                .frame(width: 2 * 98, height: 2 * 98) // Diameter is 2 * radius
            
            
            RadialLayout(radius: 98, angle: .pi / 6, offset: $offset) {
                ForEach(0..<12) { index in
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.wawTransparant)
                        Text("\(index + 1)")
                            .foregroundColor(.wawWhite50)
                            .font(.custom("LilitaOne", size: 19))
                    }
                }
            }
            .frame(width: 300, height: 300)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Calculate the temporary offset during the drag
                        let tempOffset = Double(value.translation.width / 100)
                        // Update the offset with the temporary offset
                        self.offset = self.initialOffset + tempOffset
//                        print("INI ONCHANGE \(offset)")
                    }
                    .onEnded { value in
                        // When the drag ends, update the initial offset
                        let tempOffset = Double(value.translation.width / 100)
                        self.initialOffset += tempOffset
                        // Set the current drag amount to zero for the next drag
                        self.dragAmount = .zero
//                        print("INI ONENDED \(offset)")
                    }
            )
        }
        .frame(width: 300, height: 300)
        .ignoresSafeArea()
        .padding(EdgeInsets())
        .offset(CGSize(width: 0, height: 132.0))
    }
}
