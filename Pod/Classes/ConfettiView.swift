//
//  ConfettiView.swift
//  Pods
//
//  Created by Sudeep Agarwal on 12/14/15.
//
//

import UIKit
import QuartzCore

open class ConfettiView: UIView {
    let emitter = CAEmitterLayer()
    open var colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                         UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                         UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                         UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                         UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
    open var intensity: Float =  0.5
    open var type: ConfettiType! = .confetti
    fileprivate(set) var active = false
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        self.clipsToBounds = true
    }

    open func startConfetti() {
        guard !active else { return }
        
        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color))
        }
        
        emitter.beginTime = CACurrentMediaTime()
        emitter.emitterCells = cells
        active = true

        if !(layer.sublayers?.contains(emitter) ?? false) {
            layer.addSublayer(emitter)
        }
    }

    open func stopConfetti() {
        guard active else { return }
        
        emitter.birthRate = 0
        active = false
    }

    func confettiWithColor(_ color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        // Vary each color with a slightly different birth rate so they don't come in waves
        confetti.birthRate = (6.0 + Float(arc4random()) / Float(UINT32_MAX)) * intensity
        confetti.lifetime = 14.0 * intensity
        confetti.lifetimeRange = 0
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.velocityRange = CGFloat(80.0 * intensity)
        confetti.emissionLongitude = CGFloat(Double.pi)
        confetti.emissionRange = CGFloat(Double.pi / 4)
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.scaleRange = CGFloat(intensity)
        confetti.scaleSpeed = CGFloat(-0.1 * intensity)
        confetti.contents = type.image!.cgImage
        return confetti
    }
}
