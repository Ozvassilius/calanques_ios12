//
//  BoutonArrondi.swift
//  Les Calanques
//
//  Created by Macinstosh on 06/01/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class BoutonArrondi: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()  {
        self.layer.cornerRadius = 20
    }
}
