//
//  BInt+MaybeDatable.swift
//
//
//  Created by Dr. Brandon Wiley on 1/5/24.
//

import Foundation

import Datable

extension BInt: MaybeDatable
{
    public init?(data: Data)
    {
        self.init(maybeNetworkData: data)
    }

    public var data: Data
    {
        return self.maybeNetworkData!
    }
}
