import UIKit
import SwiftGradients

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGradient(
      colors: [.beachBlue, .limeGreen],
      direction: .bottomToTop
    )
  }
}
