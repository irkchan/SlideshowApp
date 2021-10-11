//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 吉田なつみ on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    //画像の宣言
    @IBOutlet weak var slidImage: UIImageView!
    
    var image1 = UIImage(named:"img1.jpg")
    var image2 = UIImage(named:"img2.jpg")
    var image3 = UIImage(named:"img3.jpg")
    
    // どの画像にするか
    var flg = 0
    
    // タイマー
    var timer: Timer!
    
    //trueの時スライドショーが再生されている
    //falseの時スライドショーが停止している
    var timerflg = false
    
    // タイマー用の時間のための変数
    var timer_sec: Float = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button1.setTitle("進む", for:.normal)
        button2.setTitle("再生", for:.normal)
        button3.setTitle("戻る", for:.normal)
        
        //slidImageをタップして遷移するのに必要な記述
        slidImage.isUserInteractionEnabled = true;
        
        //初期画像表示
        slidImage.image = image1
    }
    
    //進むと同じ動きをchange()を使用して実行できる
    func change() {
        if flg == 0 {
            slidImage.image = image2
            flg = 1
        }
        else if flg == 1 {
            slidImage.image = image3
            flg = 2
        }else if flg == 2{
            slidImage.image = image1
            flg = 0
        }
    }
    
    // timeInterval: 2, repeats: true で指定された通り、2秒毎に呼び出され続ける
    //change()を使用し、2秒毎に画像が変わる
    @objc func updateTimer(_ timer: Timer) {
        change()
        
    }
    //進むを押した時の動き
    @IBAction func advance(_ sender: Any) {
        if flg == 0 {
            slidImage.image = image2
            flg = 1
        }
        else if flg == 1 {
            slidImage.image = image3
            flg = 2
        }else if flg == 2{
            slidImage.image = image1
            flg = 0
        }
    }
    
    //戻るを押した時の表示
    @IBAction func `return`(_ sender: Any) {
        if flg == 0 {
            slidImage.image = image3
            flg = 2
        }
        else if flg == 1 {
            slidImage.image = image1
            flg = 0
        }else if flg == 2{
            slidImage.image = image2
            flg = 1
        }
    }
    
    //再生を押した時の表示
    @IBAction func playBack(_ sender: Any) {
        if timerflg == false {
            // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
                timerflg = true
                //再生ボタンを押している間は他のボタンが使えなくなる
                button1.isEnabled = false // 再生ボタン無効
                button3.isEnabled = false // 戻るボタン無効
                button2.setTitle("停止", for: .normal)
                
            }
        }else{
            if self.timer != nil {
                self.timer.invalidate()   // タイマーを停止する
                self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
                timerflg = false
                //停止ボタンを押したらボタンが使える
                button1.isEnabled = true // 再生ボタン有効
                button3.isEnabled = true // 戻るボタン有効
                button2.setTitle("再生", for: .normal)
            }
        }
    }
    
    
    //遷移先の表示に関する記述
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultControllerを取得する
        let ResultController:ResultController = segue.destination as! ResultController
        //遷移先のResulControllerで宣言しているResultImageSrcにimageViewを代入して渡す
        ResultController.resultImagesrc = slidImage.image!
        
        if timerflg == true { //スライドショーが再生している時に、
            //遷移中は画像が2秒毎に変えるのを止める
            self.timer.invalidate()
            self.timer = nil          // startTimer() の self.timer == nil で判断するために、 self.timer = nil としておく
            timerflg = false
        }else if timerflg == false { //スライドショーが止まっている時に
            //何もしない
        }
        //停止ボタンを押したらボタンが使える
        button1.isEnabled = true // ボタン有効
        button3.isEnabled = true // ボタン有効
        //テキストを再生に戻す
        button2.setTitle("再生", for: .normal)
    }
}


