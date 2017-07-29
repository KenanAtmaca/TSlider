import UIKit

class testVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    TSlider.images = [#imageLiteral(resourceName: "c1"),#imageLiteral(resourceName: "c2"),#imageLiteral(resourceName: "c3")]
    TSlider.titles = ["1.picture","2.picture","3.picture"]
        
        TSlider.skip = {
            // code
            print("close")
        }
    
    TSlider.add(to: self.view)
        
    TSlider.mode = .dark
    TSlider.duration = 0.5
    TSlider.animation = .blur
        

    }


  
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}//


