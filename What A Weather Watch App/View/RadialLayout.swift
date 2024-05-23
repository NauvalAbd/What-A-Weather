////
////  RadialScroll.swift
////  What A Weather Watch App
////
////  Created by Nauval Abd on 22/05/24.
////
//
//import SwiftUI
//
//
//    
//    struct RadialLayout: Layout {
//        var radius: CGFloat
//        var angle: Double
//        @Binding var offset: Double
//        
//        
//        
//        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//            let maxWidth = subviews.map { $0.sizeThatFits(.unspecified).width }.max() ?? 0
//            let maxHeight = subviews.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
//            let diameter = 2 * radius + max(maxWidth, maxHeight)
//            return CGSize(width: diameter, height: diameter)
//        }
//        
//        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//            for (index, subview) in subviews.enumerated() {
//                var point = CGPoint(x: 0, y: -radius)
//                    .applying(CGAffineTransform(rotationAngle: angle * Double(index) + offset))
//                
//                point.x += bounds.midX
//                point.y += bounds.midY
//                
//                subview.place(at: point, anchor: .center, proposal: .unspecified)
//            }
//        }
//    }
//    
//    struct RadialView: View {
//        @State private var dragAmount = CGSize.zero
//            @State private var offset = 0.0
//            @State private var initialOffset = 0.0
//        
//        var body: some View {
//            ZStack {
//                // Add a circular path as the background
//                Circle()
//                    .stroke(Color.wawBlack20, lineWidth: 35)
//                    .frame(width: 2 * 87, height: 2 * 87) // Diameter is 2 * radius
//                
//                
//                RadialLayout(radius: 87, angle: .pi / 6, offset: $offset) {
//                    ForEach(0..<12) { index in
//                        ZStack {
//                            Circle()
//                                .frame(width: 20, height: 20)
//                                .foregroundColor(.wawTransparant)
//                            Text("\(index + 1)")
//                                .foregroundColor(.white)
//                                .font(.custom("LilitaOne", size: 16))
//                        }
//                    }
//                }
//                .frame(width: 300, height: 300)
//                .gesture(
//                    DragGesture()
//                        .onChanged { value in
//                            // Calculate the temporary offset during the drag
//                            let tempOffset = Double(value.translation.width / 100)
//                            // Update the offset with the temporary offset
//                            self.offset = self.initialOffset + tempOffset
//                            print("INI ONCHANGE \(offset)")
//                        }
//                        .onEnded { value in
//                            // When the drag ends, update the initial offset
//                            let tempOffset = Double(value.translation.width / 100)
//                            self.initialOffset += tempOffset
//                            // Set the current drag amount to zero for the next drag
//                            self.dragAmount = .zero
//                            print("INI ONENDED \(offset)")
//                        }
//                )
//            }
//            .frame(width: 300, height: 300)
//            .ignoresSafeArea()
//            .padding(EdgeInsets())
//            .offset(CGSize(width: 0, height: 120.0))
//            
//        }
//    }
//    
//    struct RadialView_Previews: PreviewProvider {
//        static var previews: some View {
//            RadialView()
//        }
//    }
