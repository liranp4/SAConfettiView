//
//  ConfettiType.swift
//  Pods
//
//  Created by Kyle McAlpine on 18/05/2016.
//
//

import UIKit

public enum ConfettiType {
    case confetti
    case triangle
    case star
    case diamond
    case Image(UIImage)
    
    var image: UIImage? {
        var imageName: String!
        
        switch self {
        case .confetti:
            imageName = "confetti"
        case .triangle:
            imageName = "triangle"
        case .star:
            imageName = "star"
        case .diamond:
            imageName = "diamond"
        case let .Image(customImage):
            return customImage
        }
        
        let path = Bundle(for: ConfettiView.self).path(forResource: "SAConfettiView", ofType: "bundle")
        let bundle = Bundle(path: path!)
        let imagePath = bundle?.path(forResource: imageName, ofType: "png")
        let url = URL(fileURLWithPath: imagePath!)
        let data = try? Data(contentsOf: url)
        if let data = data {
            return UIImage(data: data)!
        }
        return nil
    }
}
