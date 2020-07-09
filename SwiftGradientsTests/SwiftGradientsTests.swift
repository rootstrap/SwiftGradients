//
//  SwiftGradientsTests.swift
//  SwiftGradientsTests
//
//  Created by German on 7/9/20.
//  Copyright © 2020 Rootstrap. All rights reserved.
//

import XCTest
import UIKit
import SwiftGradients

class SwiftGradientsTests: XCTestCase {

  var view: UIView!
  
  override func setUpWithError() throws {
    view = UIView()
  }

  func testGradientLayerIsAdded() {
    let gradientLayer = view.addGradient(
      colors: [.white, .black],
      direction: .topToBottom
    )
    let firstSublayer = view.layer.sublayers?.first
    XCTAssert(firstSublayer is CAGradientLayer)
    XCTAssert(gradientLayer === firstSublayer)
  }
  
  func testGradientCorrectValues() {
    let locations = [50, 70]
    let colors: [UIColor] = [.blue, .red]
    let gradientLayer = view.addGradient(
      colors: colors,
      direction: .leftToRight,
      locations: locations
    )
    
    guard let gradientColors = gradientLayer.colors else {
      XCTFail("Gradient colors are missing.")
      return
    }
    XCTAssert(gradientColors.count == colors.count)
    for (index, gradientColor) in gradientColors.enumerated() {
      guard CFGetTypeID(gradientColor as CFTypeRef) == CGColor.typeID else {
        XCTFail("CAGradientLayer color is not a CGColor.")
        return
      }
      XCTAssert(gradientColor as! CGColor == colors[index].cgColor)
    }
    
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 0, y: 0.5))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 1, y: 0.5))
    
    guard let colorLocations = gradientLayer.locations else {
      XCTFail("Gradient colors locations are missing.")
      return
    }
    for (index, colorLocation) in colorLocations.enumerated() {
      XCTAssert(colorLocation == NSNumber(value: Float(locations[index]) / 100))
    }
  }
  
  func testGradientAngleCalculation() {
    let colors: [UIColor] = [.yellow, .green]
    var gradientLayer = view.addGradient(colors: colors, angle: 90)
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 0.5, y: 0))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 0.5, y: 1))
    
    gradientLayer = view.addGradient(colors: colors, angle: 270)
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 0.5, y: 1))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 0.5, y: 0))
    
    gradientLayer = view.addGradient(colors: colors, angle: 180)
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 0, y: 0.5))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 1, y: 0.5))
    
    gradientLayer = view.addGradient(colors: colors, angle: 0)
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 1, y: 0.5))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 0, y: 0.5))
  }
}
