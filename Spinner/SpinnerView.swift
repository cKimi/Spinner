//
//  SpinnerView.swift
//  Spinner
//
//  Created by Carlos Kimura on 29/01/23.
//

import SwiftUI

struct SpinnerView: View {
    @State var currentIndex: Int?
    
    struct Leaf: View {
        let rotation: Angle
        let isCurrent: Bool
        
        var body: some View {
            Capsule()
                .stroke(isCurrent ? Color.white : Color.gray, lineWidth: 8)
                .frame(width: 20, height: 50)
                .offset(x: isCurrent ? 10 : 0, y: isCurrent ? 40 : 70)
                .scaleEffect(isCurrent ? 0.5 : 1.0)
                .rotationEffect(rotation)
                .animation(.easeInOut(duration: 1.5), value: isCurrent)
        }
    }
    
    let leavesCount = 12
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<leavesCount) { index in
                    Leaf(rotation: Angle(degrees: (Double(index) / Double(self.leavesCount)) * 360.0), isCurrent: index == self.currentIndex)
                }
            }
            .onAppear(perform: animate)
        }
    }
    
    func animate() {
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if let current = self.currentIndex {
                self.currentIndex = (current + 1) % self.leavesCount
            } else {
                self.currentIndex = 0
            }
        }
    }
}

#if DEBUG
struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
#endif
