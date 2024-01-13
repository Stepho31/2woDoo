//
//  LottieView.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/8/24.
//

import Foundation
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var filename: String
    @Binding var shouldAnimate: Bool

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play { finished in
            if finished {
                shouldAnimate = false
            }
        }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if shouldAnimate {
            let animationView = uiView.subviews.first { $0 is AnimationView } as? AnimationView
            animationView?.play()
        }
    }
}
