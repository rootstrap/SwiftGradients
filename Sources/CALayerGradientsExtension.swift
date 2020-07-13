//
//  CALayerGradientsExtension.swift
//  SwiftGradients
//
//  Created by German Lopez on 7/8/20.
//  Copyright © 2020 Rootstrap. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension CALayer {
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
  
  /// Angle param is measured anti-clockwise
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
  
  ///  This method will add a gradient sublayer in background with the given colors,
  ///  points and locations for color stops(in %[0-100]).
  @discardableResult
  func addGradient(
    colors: [UIColor],
    startPoint: CGPoint,
    endPoint: CGPoint,
    locations: [Int] = []
  ) -> CAGradientLayer {
    var gradient: CAGradientLayer
    if let current = sublayers?.first as? CAGradientLayer {
      gradient = current
    } else {
      gradient = CAGradientLayer()
      insertSublayer(gradient, at: 0)
    }
    gradient.frame = bounds
    gradient.uiColors = colors
    
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    if !locations.isEmpty {
      gradient.percentLocations = locations
    }
    return gradient
  }
}

#endif
