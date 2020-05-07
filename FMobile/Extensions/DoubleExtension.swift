/*
Copyright (C) 2020 Groupe MINASTE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
//
//  DoubleExtension.swift
//  FMobile
//
//  Created by PlugN on 27/04/2019.
//  Copyright © 2019 Groupe MINASTE. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toSpeedtest() -> (String?, String?) {
        if self < 1 {
            return ("\(Int((self * 1000).rounded()))", "Kbps")
        }
        return ("\(self.rounded(toPlaces: 3))", "Mbps")
    }
    
}
