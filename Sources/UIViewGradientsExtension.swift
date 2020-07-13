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

public enum GradientDirection: CGFloat, CaseIterable {
  case leftToRight = 0
  case topToBottom = 90
  case rightToLeft = 180
  case bottomToTop = 270
  
  var startPoint: CGPoint {
    switch self {
    case .topToBottom:
      return CGPoint(x: 0.5, y: 0.0)
    case .bottomToTop:
      return CGPoint(x: 0.5, y: 1.0)
    case .leftToRight:
      return CGPoint(x: 0.0, y: 0.5)
    case .rightToLeft:
      return CGPoint(x: 1.0, y: 0.5)
    }
  }
  
  var endPoint: CGPoint {
    switch self {
    case .topToBottom:
      return CGPoint(x: 0.5, y: 1.0)
    case .bottomToTop:
      return CGPoint(x: 0.5, y: 0.0)
    case .leftToRight:
      return CGPoint(x: 1.0, y: 0.5)
    case .rightToLeft:
      return CGPoint(x: 0.0, y: 0.5)
    }
  }
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
    angle: CGFloat,
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
  
  func addGradient(colors: [UIColor], angle: CGFloat, locations: [Int] = []) {
    for view in self {
      view.addGradient(colors: colors, angle: angle, locations: locations)
    }
  }
}

#endif
