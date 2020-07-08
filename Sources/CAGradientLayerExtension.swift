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
  class func startPointFor(_ angle: Double) -> CGPoint {
    if let defaultDirection = GradientDirection(rawValue: angle) {
      switch defaultDirection {
      case .topToBottom:
        return CGPoint(x: 0.5, y: 0.0)
      case .bottomToTop:
        return CGPoint(x: 0.5, y: 1.0)
      case .leftToRight:
        return CGPoint(x: 0.0, y: 0.5)
      default:
        return CGPoint(x: 1.0, y: 0.5)
      }
    }
    return pointWithAngle(angle)
  }

  class func endPointFor(_ angle: Double) -> CGPoint {
    if let defaultDirection = GradientDirection(rawValue: angle) {
      switch defaultDirection {
      case .topToBottom:
        return CGPoint(x: 0.5, y: 1.0)
      case .bottomToTop:
        return CGPoint(x: 0.5, y: 0.0)
      case .leftToRight:
        return CGPoint(x: 1.0, y: 0.5)
      default:
        return CGPoint(x: 0.0, y: 0.5)
      }
    }
    return pointWithAngle(angle, isStartPoint: false)
  }

  ///  **pointWithAngle**: Helper for CAGradientLayer's start and endPoint given an angle in degrees
  ///  - Parameter **angle** The desired angle in degrees and measured anti-clockwise.
  ///  - Parameter **isStartPoint** A boolean indicating which point you need.
  ///  - Returns: The initial or ending CGPoint for a CAGradientLayer within the Unit Cordinate System.
  private class func pointWithAngle(
    _ angle: Double,
    isStartPoint: Bool = true
  ) -> CGPoint {
    //  negative angles not allowed
    var positiveAngle = angle < 0 ? angle * -1.0 : angle
    var y1: Double, y2: Double, x1: Double, x2: Double

    if // ranges when we know Y values
      (positiveAngle >= 45 && positiveAngle <= 135) ||
      (positiveAngle >= 225 && positiveAngle <= 315)
    {
      y1 = positiveAngle < 180 ? 0.0 : 1.0
      y2 = 1.0 - y1 //opposite to start Y
      x1 = positiveAngle >= 45 && positiveAngle <= 135 ?
        1.5 - positiveAngle / 90 :
        abs(2.5 - positiveAngle / 90)
      x2 = 1.0-x1 //opposite to start X
    } else { // ranges when we know X values
      x1 = positiveAngle < 45 || positiveAngle >= 315 ? 1.0 : 0.0
      x2 = 1.0 - x1
      if positiveAngle > 135 && positiveAngle < 225 {
        y2 = abs(2.5 - positiveAngle / 90)
        y1 = 1.0 - y2
      } else { // Range 0-45 315-360
        //Turn this ranges into one single 90 degrees range
        positiveAngle = positiveAngle >= 0 && positiveAngle <= 45 ?
          45.0 - positiveAngle :
          360 - positiveAngle + 45
        y1 = positiveAngle / 90
        y2 = 1.0 - y1
      }
    }
    return isStartPoint ? CGPoint(x: x1, y: y1) : CGPoint(x: x2, y: y2)
  }
}

#endif
