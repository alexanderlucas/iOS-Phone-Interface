//
//  ViewController.swift
//  PhoneInterface
//
//  Created by Jing Li on 1/24/18.
//  Copyright © 2018 Jing Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myCallButton: UIButton!
    @IBOutlet weak var endCallButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var inCall = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numberView.layer.cornerRadius = numberView.frame.width / 2;
        endCallButton.isHidden = true;
    }
    

    @IBAction func digitPressed(_ sender: UIButton) {
        if inCall {
            return
        }
        
        var str = myLabel.text! + sender.currentTitle!
        
        switch (str.count) {
        case 4:
            if(!str.contains("*") && !str.contains("#")){
                str.insert("-", at: (str.index((str.startIndex), offsetBy: 3)))

            }
        case 9:
            if(!str.contains("*") && !str.contains("#")){
                str.remove(at: (str.index((str.startIndex), offsetBy: 3)))
                str.insert("(", at: str.startIndex)
                str.insert(")", at: str.index(str.startIndex, offsetBy: 4))
                str.insert(" ", at: str.index(str.startIndex, offsetBy: 5))
                str.insert("-", at: str.index(str.startIndex, offsetBy: 9))
            }
           
        case 14:
            if (str.prefix(1) == "(" && !str.contains("*") && !str.contains("#")){
                myCallButton.isEnabled = true

            }

        case 15:
            if (str.prefix(1) == "(" && !str.contains("*") && !str.contains("#")){
                str.remove(at: (str.index((str.startIndex), offsetBy: 9)))
                str.remove(at: (str.index((str.startIndex), offsetBy: 5)))
                str.remove(at: (str.index((str.startIndex), offsetBy: 4)))
                str.remove(at: str.startIndex)
                myCallButton.isEnabled = false

            }

        default:
            break
        }
        
        myLabel.text = str
        deleteButton.isEnabled = true
       
    }
    
    @IBAction func makeCall(_ sender: UIButton) {
        
        if !(myLabel.text?.contains("#"))! && !(myLabel.text?.contains("*"))! {
            endCallButton.isHidden = false
            myCallButton.isHidden = true

            myLabel.text = "call initiated..."
            inCall = true
            deleteButton.isEnabled = false
        }
    }
    
    @IBAction func endCall(_ sender: UIButton) {
        endCallButton.isHidden = true
        myCallButton.isHidden = false
        
        myLabel.text = ""
        
        inCall = false


    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
       

        var str = myLabel.text!.prefix((myLabel.text?.count)! - 1)
        
        switch str.count {
        case 11:
            if(str.contains("-") ){
                str.remove(at: (str.index((str.startIndex), offsetBy: 9)))
                str.remove(at: (str.index((str.startIndex), offsetBy: 5)))
                str.remove(at: (str.index((str.startIndex), offsetBy: 4)))
                str.remove(at: (str.index((str.startIndex), offsetBy: 0)))
                str.insert("-", at: (str.index((str.startIndex), offsetBy: 3)))
                
            }
           
        case 10:
            if(!str.contains("-") && !str.contains("*") && !str.contains("#")){
                str.insert("(", at: str.startIndex)
                str.insert(")", at: str.index(str.startIndex, offsetBy: 4))
                str.insert(" ", at: str.index(str.startIndex, offsetBy: 5))
                str.insert("-", at: str.index(str.startIndex, offsetBy: 9))
                myCallButton.isEnabled = true

            }

        case 13:
            myCallButton.isEnabled = false
            
        case 4:
            if( !str.contains("*") && !str.contains("#")){
                str.remove(at: (str.index((str.startIndex), offsetBy: 3)))

            }

        case 0:
            deleteButton.isEnabled = false


        default:
            break
        }
        
        
        
        myLabel.text = String(str)

    }
}

