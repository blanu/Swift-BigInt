//
//  BInt+MaybeNetworkDatable.swift
//
//
//  Created by Dr. Brandon Wiley on 12/19/23.
//

import Foundation

import Datable

extension BInt: MaybeNetworkDatable
{
    public init?(maybeNetworkData: Data)
    {
        var data = maybeNetworkData
        var limbs: [UInt64] = []

        while data.count > 0
        {
            guard data.count >= 4 else
            {
                return nil
            }

            let chunk = Data(data[0..<4])
            data = Data(data[4...])

            guard let limb = chunk.maybeNetworkUint64 else
            {
                return nil
            }

            limbs.append(limb)
        }

        self.init(limbs: limbs)
    }

    public var maybeNetworkData: Data?
    {
        var result: Data = Data()

        for limb in self.limbs
        {
            guard let limbData = limb.maybeNetworkData else
            {
                return nil
            }

            result.append(limbData)
        }

        return result
    }
}
