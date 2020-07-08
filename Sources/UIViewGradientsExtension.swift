//
//  GeneralHelper.swift
//  swift-base
//
//  Created by German Lopez on 2/19/16.
//  Copyright © 2016 Rootstrap Inc. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

public enum GradientDirection: Double {
  case topToBottom = 90.0
  case bottomToTop = 270.0
  case leftToRight = 180.0
  case rightToLeft = 0.0
}

public extension UIView {
  @discardableResult
  func addGradient(
    colors: [UIColor],
    direction: GradientDirection = .topToBottom,
    locations: [Int] = []
  ) -> CAGradientLayer {
    return addGradient(
      colors: colors,
      startPoint: CAGradientLayer.startPointFor(direction.rawValue),
      endPoint: CAGradientLayer.endPointFor(direction.rawValue),
      locations: locations
    )
  }
  
  @discardableResult
  func addGradient(
    colors: [UIColor],
    angle: Double,
    locations: [Int] = []
  ) -> CAGradientLayer {
    return addGradient(
      colors: colors,
      startPoint: CAGradientLayer.startPointFor(angle),
      endPoint: CAGradientLayer.endPointFor(angle),
      locations: locations
    )
  }
  
  @discardableResult
  func addGradient(
    colors: [UIColor],
    startPoint: CGPoint,
    endPoint: CGPoint,
    locations: [Int] = []
  ) -> CAGradientLayer {
    return layer.addGradient(
      colors: colors,
      startPoint: startPoint,
      endPoint: endPoint,
      locations: locations
    )
  }
}

public extension Array where Element: UIView {
  func addGradient(
    withColors colors: [UIColor],
    direction: GradientDirection = .topToBottom,
    locations: [Int] = []
  ) {
    for view in self {
      view.addGradient(colors: colors, direction: direction, locations: locations)
    }
  }
  
  func addGradient(colors: [UIColor], angle: Double, locations: [Int] = []) {
    for view in self {
      view.addGradient(colors: colors, angle: angle, locations: locations)
    }
  }
}

#endif
