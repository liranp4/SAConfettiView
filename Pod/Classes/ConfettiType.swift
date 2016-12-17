//
//  ConfettiType.swift
//  Pods
//
//  Created by Kyle McAlpine on 18/05/2016.
//
//

import UIKit

public enum ConfettiType {
    case Confetti
    case Triangle
    case Star
    case Diamond
    case Image(UIImage)
    
    var image: UIImage? {
        var imageName: String!
        
        switch self {
        case .Confetti:
            imageName = "confetti"
        case .Triangle:
            imageName = "triangle"
        case .Star:
            imageName = "star"
        case .Diamond:
            imageName = "diamond"
        case let .Image(customImage):
            return customImage
        }
        
        let path = NSBundle(forClass: ConfettiView.self).pathForResource("SAConfettiView", ofType: "bundle")
        let bundle = NSBundle(path: path!)
        let imagePath = bundle?.pathForResource(imageName, ofType: "png")
        let url = NSURL(fileURLWithPath: imagePath!)
        let data = NSData(contentsOfURL: url)
        if let data = data {
            return UIImage(data: data)!
        }
        return nil
    }
}
