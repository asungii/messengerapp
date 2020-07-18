//
//  Extensions.swift
//  Messenger
//
//  Created by Laerdon Kim on 7/17/20.
//  Copyright © 2020 Laerdon Kim. All rights reserved.
//

import Foundation
import UIKit

// Creating shorthands for things like view.frame.size

extension UIView {
    public var width :CGFloat {
        return self.frame.size.width
    }
    
    public var height :CGFloat {
        return self.frame.size.height
    }
    
    public var top :CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom :CGFloat {
        return self.frame.height + self.frame.origin.y
    }
    
    public var left :CGFloat {
        return self.frame.origin.x
    }
    
    public var right :CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }

}
