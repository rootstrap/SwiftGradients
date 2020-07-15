//
//  CAGradientLayerExtension.swift
//  SwiftGradients
//
//  Created by German Lopez on 7/8/20.
//  Copyright © 2020 Rootstrap. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

extension CAGradientLayer {
  //MARK: Attributes accessors

  /// Collection of UIColors used in the gradient.
  public var uiColors: [UIColor] {
    get {
      guard let anyColors = colors else { return [] }
      return anyColors.map { color in
        CFGetTypeID(color as CFTypeRef) == CGColor.typeID ?
          UIColor(cgColor: color as! CGColor) :
          UIColor.clear
      }
    }
    set {
      colors = newValue.map { $0.cgColor }
    }
  }
  
  /// Color stop locations in percentages.
  public var percentLocations: [Int] {
    get {
      guard let decimalLocations = locations else { return [] }
      return decimalLocations.map { Int(exactly: $0.floatValue * 100) ?? 0 }
    }
    set{
      locations = newValue.map { NSNumber(value: Float($0) / 100.0) }
    }
  }
  
  /// Predefined gradient direction if specified or if the current angle
  /// matches any of the GradientDirection cases.
  public var direction: GradientDirection? {
    get {
      if
        let direction = GradientDirection.allCases.first(where: { direction in
          abs(direction.startPoint.x - startPoint.x) <= .ulpOfOne &&
          abs(direction.startPoint.y - startPoint.y) <= .ulpOfOne &&
          abs(direction.endPoint.x - endPoint.x) <= .ulpOfOne &&
          abs(direction.endPoint.y - endPoint.y) <= .ulpOfOne
        })
      {
        return direction
      }
      return nil
    }
    set {
      guard let newDirection = newValue else { return }
      startPoint = newDirection.startPoint
      endPoint = newDirection.endPoint
    }
  }
  
  /// The gradient angle in degrees, measured clockwise and starting at the left.
  /// 0 -> left, 90 -> up, etc
  public var angle: CGFloat {
    get {
      let product = endPoint.y - startPoint.y
      let determinant = endPoint.x - startPoint.x
      var degrees = CGFloat(atan2(product, determinant)) * 180 / CGFloat.pi
      if degrees < 0 { degrees = 360 + degrees }
      
      return degrees.truncatingRemainder(dividingBy: 360)
    }
    set {
      startPoint = CAGradientLayer.startPointFor(newValue)
      endPoint = CAGradientLayer.endPointFor(newValue)
    }
  }
  
  //MARK: Angle and points helpers

  class func startPointFor(_ angle: CGFloat) -> CGPoint {
    return pointWithAngle(angle)
  }

  class func endPointFor(_ angle: CGFloat) -> CGPoint {
    return pointWithAngle(angle, isStartPoint: false)
  }

  ///  **pointWithAngle**: Helper for CAGradientLayer's start and endPoint
  ///  given an angle in degrees
  ///  - Parameter **angle** The desired angle in degrees, measured clockwise
  ///  and starting at the left.
  ///  - Parameter **isStartPoint** A boolean indicating which point you need.
  ///  - Returns: The initial or ending CGPoint for a CAGradientLayer
  ///  within the Unit Cordinate System.
  private class func pointWithAngle(
    _ angle: CGFloat,
    isStartPoint: Bool = true
  ) -> CGPoint {
    var ang = (-angle).truncatingRemainder(dividingBy: 360)
    if ang < 0 { ang = 360 + ang }
    let n: CGFloat = 0.5

    switch ang {
    case 0...45, 315...360:
      return isStartPoint ?
        CGPoint(x: 0, y: n * tanx(ang) + n) :
        CGPoint(x: 1, y: n * tanx(-ang) + n)
    case 45...135:
      return isStartPoint ?
        CGPoint(x: n * tanx(ang - 90) + n, y: 1) :
        CGPoint(x: n * tanx(-ang - 90) + n, y: 0)
    case 135...225:
      return isStartPoint ?
        CGPoint(x: 1, y: n * tanx(-ang) + n) :
        CGPoint(x: 0, y: n * tanx(ang) + n)
    case 225...315:
      return isStartPoint ?
        CGPoint(x: n * tanx(-ang - 90) + n, y: 0) :
        CGPoint(x: n * tanx(ang - 90) + n, y: 1)
    default:
      return isStartPoint ?
        CGPoint(x: 0, y: n) :
        CGPoint(x: 1, y: n)
    }
  }

  private class func tanx(_ 𝜽: CGFloat) -> CGFloat {
    return tan(𝜽 * CGFloat.pi / 180)
  }
}

#endif
