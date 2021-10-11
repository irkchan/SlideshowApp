//
//  ResultController.swift
//  SlideshowApp
//
//  Created by 吉田なつみ on 2021/10/08.
//

import UIKit

class ResultController: UIViewController {
    @IBOutlet weak var resultImage: UIImageView!
    var resultImagesrc = UIImage(named:"img1.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resultImage.image = resultImagesrc
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
