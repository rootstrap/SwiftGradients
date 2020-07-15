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
    XCTAssertEqual(gradientLayer.startPoint.x, 0.5, accuracy: .ulpOfOne)
    XCTAssertEqual(gradientLayer.endPoint.x, 0.5, accuracy: .ulpOfOne)
    XCTAssert(gradientLayer.startPoint.y == 0)
    XCTAssert(gradientLayer.endPoint.y == 1)
    
    gradientLayer = view.addGradient(colors: colors, angle: 270)
    XCTAssertEqual(gradientLayer.startPoint.x, 0.5, accuracy: .ulpOfOne)
    XCTAssertEqual(gradientLayer.endPoint.x, 0.5, accuracy: .ulpOfOne)
    XCTAssert(gradientLayer.startPoint.y == 1)
    XCTAssert(gradientLayer.endPoint.y == 0)
    
    gradientLayer = view.addGradient(colors: colors, angle: 180)
    XCTAssertEqual(gradientLayer.startPoint.y, 0.5, accuracy: .ulpOfOne)
    XCTAssertEqual(gradientLayer.endPoint.y, 0.5, accuracy: .ulpOfOne)
    XCTAssert(gradientLayer.startPoint.x == 1)
    XCTAssert(gradientLayer.endPoint.x == 0)
    
    gradientLayer = view.addGradient(colors: colors, angle: 0)
    XCTAssert(gradientLayer.startPoint == CGPoint(x: 0, y: 0.5))
    XCTAssert(gradientLayer.endPoint == CGPoint(x: 1, y: 0.5))
  }
  
  //MARK: Accessors

  func testUIColorAccessor() {
    let locations = [50, 70]
    let finalColors: [UIColor] = [.white, .black]
    let gradientLayer = view.addGradient(
      colors: [.blue, .red],
      locations: locations
    )
    gradientLayer.uiColors = finalColors
    let uiColors = gradientLayer.uiColors
    XCTAssert(uiColors == finalColors)
  }
  
  func testPercentLocationsAccessor() {
    let initialStop = Int(arc4random_uniform(100))
    let locations = [
      initialStop,
      initialStop + Int(arc4random_uniform(UInt32(100 - initialStop)))
    ]
    let gradientLayer = view.addGradient(colors: [.white, .black])
    gradientLayer.percentLocations = locations
    XCTAssert(locations == gradientLayer.percentLocations)
  }
  
  func testDirectionAccessor() {
    guard let direction = GradientDirection.allCases.randomElement() else {
      XCTFail("Invalid gradient direction case.")
      return
    }

    let gradientLayer = view.addGradient(colors: [.purple, .cyan])
    gradientLayer.direction = direction
    XCTAssert(direction == gradientLayer.direction)
    
    gradientLayer.angle = 0
    XCTAssert(gradientLayer.direction == .leftToRight)
    gradientLayer.angle = 90
    XCTAssert(gradientLayer.direction == .topToBottom)
    gradientLayer.angle = 180
    XCTAssert(gradientLayer.direction == .rightToLeft)
    gradientLayer.angle = 270
    XCTAssert(gradientLayer.direction == .bottomToTop)
    gradientLayer.angle = 360
    XCTAssert(gradientLayer.direction == .leftToRight)
  }
  
  func testAngleAccessor() {
    let gradientLayer = view.addGradient(colors: [.brown, .orange])
    gradientLayer.angle = 0
    XCTAssert(gradientLayer.angle == 0)
    gradientLayer.angle = 90
    XCTAssertEqual(gradientLayer.angle, 90, accuracy: 0.001)
    gradientLayer.angle = 180
    XCTAssertEqual(gradientLayer.angle, 180, accuracy: 0.001)
    gradientLayer.angle = 270
    XCTAssertEqual(gradientLayer.angle, 270, accuracy: 0.001)
    gradientLayer.angle = 360
    XCTAssert(gradientLayer.angle == 0)
    gradientLayer.angle = 450
    XCTAssertEqual(gradientLayer.angle, 90, accuracy: 0.001)
  }
}
