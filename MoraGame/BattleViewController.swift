//
//  BattleViewController.swift
//  BattleViewController
//
//  Created by 連振甫 on 2021/8/1.
//

import UIKit

enum Direction:Int{
    case up = 0
    case right
    case left
    case down
    
    var string:String {
        switch self {
        case .up:
            return "👆"
        case .right:
            return "👉"
        case .left:
            return "👈"
        case .down:
            return "👇"
        }
    }
}

enum Player {
    case pc
    case mine
    
    var string:String {
        switch self {
        case .pc:
            return "電腦"
        case .mine:
            return "你"
        }
    }
}

class BattleViewController: UIViewController {

    var beginUser: Player = .pc
    var currentUser: Player = .pc
    var direction: Direction = .up
    var checkCount = 5
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var mineImage: UIImageView!
    @IBOutlet weak var pcImage: UIImageView!
    
    private var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentUser = beginUser
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(downCount), userInfo: nil, repeats: true)
        
    }
    
    @objc func downCount(){
        
        
        
        self.checkCount -= 1
        if self.checkCount == 0 {
            self.timeLabel.text = "時間到，你輸了"
            timer?.invalidate()
            timer = nil
        }
        else {
            self.timeLabel.text = "換\(currentUser.string)猜，剩餘\(self.checkCount)秒"
        }
    }
    
    @IBAction func selectedMora(_ sender: UIButton) {
        
        if checkCount == 0 {
            return
        }
        
        checkCount = 5
        let pcSelected = Int.random(in: 0...3)
        pcImage.image = UIImage(named: "Image-\(pcSelected)")
        mineImage.image = UIImage(named: "Image-\(sender.tag)")
        
        if currentUser == .pc {
            if (sender.tag != pcSelected) {
                currentUser = .mine
            }else{
                timer?.invalidate()
                timer = nil
                timeLabel.text = "你輸了"
            }
        }else{
            if (sender.tag != pcSelected) {
                currentUser = .pc
            }else{
                timer?.invalidate()
                timer = nil
                timeLabel.text = "你贏了"
            }
            
        }
        
        
    }
    
}
