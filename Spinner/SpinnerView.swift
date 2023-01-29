//
//  SpinnerView.swift
//  Spinner
//
//  Created by Carlos Kimura on 29/01/23.
//

import SwiftUI

struct SpinnerView: View {
    @State var currentIndex: Int?
    @State var completed = false
    @State var isVisible = true
    let shootUp = AnyTransition
        .offset(CGSize(width: 0, height: -1000))
        .animation(.easeIn(duration: 1.0))
    
    struct Leaf: View {
        let rotation: Angle
        let isCurrent: Bool
        let isCompleting: Bool
        
        var body: some View {
            Capsule()
                .stroke(isCurrent ? Color.white : Color.gray, lineWidth: 8)
                .frame(width: 20, height: isCompleting ? 20 : 50)
                .offset(x: isCurrent ? 10 : 0, y: isCurrent ? 40 : 70)
                .scaleEffect(isCurrent ? 0.5 : 1.0)
                .rotationEffect(isCompleting ? .zero : rotation)
                .animation(.easeInOut(duration: 1.5), value: isCompleting)
        }
    }
    
    let leavesCount = 12
    
    var body: some View {
        VStack {
            if isVisible {
                ZStack {
                    ForEach(0..<leavesCount) { index in
                        Leaf(rotation: Angle(degrees: (Double(index) / Double(self.leavesCount)) * 360.0), isCurrent: index == self.currentIndex, isCompleting: self.completed)
                    }
                }
                .onAppear(perform: animate)
                .transition(shootUp)
            }
        }
    }
    
    func animate() {
        var iteration = 0
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if let current = self.currentIndex {
                self.currentIndex = (current + 1) % self.leavesCount
            } else {
                self.currentIndex = 0
            }
            
            iteration += 1
            if iteration == 60 {
                timer.invalidate()
                self.complete()
            }
        }
    }
    
    func complete() {
        guard !completed else { return }
        
        completed = true
        currentIndex = nil
        delay(seconds: 2) {
            withAnimation {
                self.isVisible = false
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
