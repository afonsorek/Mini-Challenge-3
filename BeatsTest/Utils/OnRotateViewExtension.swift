//
//  OnRotateViewExtension.swift
//  BeatsTest
//
//  Created by Rafa (Ruffles) on 08/11/23.
//

import Foundation
import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    // oi
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
