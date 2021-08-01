//
//  ViewController.swift
//  MoraGame
//
//  Created by 連振甫 on 2021/8/1.
//

import UIKit

enum Mora:Int {
    case Scissors = 0
    case Stone
    case paper
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = Mora.Scissors
        case 1:
            self = Mora.Stone
        case 2:
            self = Mora.paper
        default :
            self = Mora.Scissors
        }
    }
    
    var emoji:String {
        switch self {
        case .Scissors:
            return "✌️"
        case .Stone:
            return "✊"
        case .paper:
            return "✋"
        }
    }
}

enum MoraResult:String {
    case win = "你贏了"
    case lose = "你輸了"
    case draw = "平手"
}

class ViewController: UIViewController {

    @IBOutlet weak var pcLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var resLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func Scissors(_ sender: UITapGestureRecognizer) {
        
        let pcSelected = Int.random(in: 0...2)
        print(pcSelected)
        let pcMora = Mora.init(rawValue: pcSelected)
        
        
        switch pcMora {
        case .Scissors:
            print("平手")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Scissors.emoji,res: MoraResult.draw.rawValue)
        case .Stone:
            print("lose")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Scissors.emoji,res: MoraResult.lose.rawValue)
        case .paper:
            print("win")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Scissors.emoji,res: MoraResult.win.rawValue)
        }
        
    }
    
    @IBAction func Stone(_ sender: UITapGestureRecognizer) {
        let pcSelected = Int.random(in: 0...2)
        print(pcSelected)
        let pcMora = Mora.init(rawValue: pcSelected)
        
        switch pcMora {
        case .Scissors:
            print("win")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Stone.emoji,res: MoraResult.win.rawValue)
        case .Stone:
            print("平手")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Stone.emoji,res: MoraResult.draw.rawValue)
        case .paper:
            print("lose")
            setupGameLabel(pc: pcMora.emoji, my: Mora.Stone.emoji,res: MoraResult.lose.rawValue)
        }
    }
    
    @IBAction func paper(_ sender: UITapGestureRecognizer) {
        let pcSelected = Int.random(in: 0...2)
        print(pcSelected)
        let pcMora = Mora.init(rawValue: pcSelected)
        
        switch pcMora {
        case .Scissors:
            print("lose")
            setupGameLabel(pc: pcMora.emoji, my: Mora.paper.emoji,res: MoraResult.lose.rawValue)
        case .Stone:
            print("win")
            setupGameLabel(pc: pcMora.emoji, my: Mora.paper.emoji,res: MoraResult.win.rawValue)
        case .paper:
            print("平手")
            setupGameLabel(pc: pcMora.emoji, my: Mora.paper.emoji,res: MoraResult.draw.rawValue)
        }
    }
    
    func setupGameLabel(pc:String,my:String,res:String){
        
        pcLabel.text = pc
        myLabel.text = my
        resLabel.text = res
        
        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BattleViewController") as! BattleViewController
        
        switch res {
        case MoraResult.win.rawValue:
            let alert = UIAlertController(title: "你贏了", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: {[weak self] _ in
                
                vc.beginUser = .mine
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        case MoraResult.lose.rawValue:
            let alert = UIAlertController(title: "電腦贏了", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: {[weak self] _ in
                
                vc.beginUser = .pc
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        
    }
}

