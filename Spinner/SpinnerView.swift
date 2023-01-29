//
//  SpinnerView.swift
//  Spinner
//
//  Created by Carlos Kimura on 29/01/23.
//

import SwiftUI

struct SpinnerView: View {
    struct Leaf: View {
        var body: some View {
            Capsule()
                .stroke(Color.gray, lineWidth: 8)
                .frame(width: 20, height: 50)
        }
    }
    
    let leavesCount = 12
    
    var body: some View {
        VStack {
            ZStack {
                Leaf()
            }
            .onAppear(perform: animate)
        }
    }
    
    func animate() {
        
    }
}

#if DEBUG
struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
#endif
