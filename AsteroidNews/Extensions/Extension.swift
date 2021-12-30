//
//  Extension.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 16/12/21.
//

import Foundation
import UIKit

@IBDesignable class myButton : UIButton {}
extension UIView {
    @IBInspectable var borderColor:UIColor{
        set{
            self.layer.borderColor = (newValue as UIColor).cgColor
        }
        get{
            let color  = self.layer.borderColor
            return UIColor(cgColor: color!)
        }
    }
    
    @IBInspectable var borderWidth:CGFloat{
        set{
            self.layer.borderWidth = newValue
        }
        get{
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat{
        set{
            self.layer.cornerRadius = newValue
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var maskToBounds:Bool{
        set{
            self.layer.masksToBounds = newValue
        }
        get{
            return self.layer.masksToBounds
        }
    }
}
