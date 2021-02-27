//
//  View+Convinience.swift
//  iOSTechChallenge
//
//  Created by Raphael Pedrini on 27/02/2021.
//

import SwiftUI

extension View {
    
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
