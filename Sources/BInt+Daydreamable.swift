//
//  BInt+Daydreamable.swift
//
//
//  Created by Dr. Brandon Wiley on 1/12/24.
//

import Foundation

import Daydream

extension BInt: Daydreamable
{
    public var daydream: Data
    {
        return self.varint
    }

    public init(daydream data: Data) throws
    {
        guard let bint = BInt(varint: data) else
        {
            throw BIntError.conversionFailed
        }

        self = bint
    }
}

public enum BIntError: Error
{
    case conversionFailed
}
