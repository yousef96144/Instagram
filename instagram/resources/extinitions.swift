//
//  extinitions.swift
//  instagram
//
//  Created by yousef Elaidy on 15/12/2023.
//

import Foundation
import UIKit

extension UIView{
    public var width:CGFloat{
        return frame.size.width
    }
    public var height:CGFloat{
        return frame.size.height
    }
    public var top:CGFloat{
        return frame.origin.y
    }
    public var bottom:CGFloat{
        return frame.origin.y+frame.size.height
    }
    public var right:CGFloat{
        return frame.origin.x+frame.size.width
    }
    public var left:CGFloat{
        return frame.origin.x
    }
}
extension String{
    func safedatabasekey() -> String {
        
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "_")
    }
}
