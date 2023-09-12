//
//  Extensions.swift
//  cis
//
//  Created by cici on 8/6/2023.
//

import UIKit
extension UIView{
    
    public var width: CGFloat{
        return frame.size.width
    }
    public var height: CGFloat{
        return frame.size.height
    }
    public var top: CGFloat{
        return frame.origin.y
    }
    public var bottom: CGFloat{
        return frame.origin.x
    }
    public var right: CGFloat{
        return frame.origin.x+frame.size.width
    }
    public var left: CGFloat{
        return frame.origin.y
    }
    
    
}

extension String{
     func safeDatabaseKey() -> String{
        
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")

    }
}
