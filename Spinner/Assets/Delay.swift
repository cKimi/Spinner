//
//  Delay.swift
//  Spinner
//
//  Created by Carlos Kimura on 29/01/23.
//

import Foundation

func delay(seconds: TimeInterval, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: block)
}
