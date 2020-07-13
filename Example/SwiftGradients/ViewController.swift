import UIKit
import SwiftGradients

class ViewController: UIViewController {
  
  var gradientLayer: CAGradientLayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    gradientLayer = view.addGradient(
      colors: [.beachBlue, .limeGreen],
      direction: .bottomToTop
    )
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let randomChange = arc4random_uniform(4)
    switch randomChange {
    case 0:
      self.gradientLayer.uiColors = [UIColor.random, UIColor.random]
    case 1:
      let initialStop = Int(arc4random_uniform(100))
      gradientLayer.percentLocations = [
        initialStop,
        initialStop + Int(arc4random_uniform(UInt32(100 - initialStop)))
      ]
    case 2:
      gradientLayer.direction = .rightToLeft
    case 3:
      gradientLayer.angle = CGFloat(arc4random_uniform(360))
    default:
      break
    }
  }
}

extension UIColor {
  static var random: UIColor {
    return UIColor(
      red: CGFloat(arc4random_uniform(255)) / 255,
      green: CGFloat(arc4random_uniform(255)) / 255,
      blue: CGFloat(arc4random_uniform(255)) / 255,
      alpha: 1
    )
  }
}
