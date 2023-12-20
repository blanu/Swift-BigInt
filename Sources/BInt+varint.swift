//
//  BInt+varint.swift
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

        guard let firstByte = data.first else
        {
            return nil
        }
        data = data.dropFirst()

        let count = Int(firstByte)
        for _ in 0..<count
        {
            guard data.count >= 4 else
            {
                return nil
            }

            let chunk = data[0..<4]
            data = data[4...]

            guard let limb = chunk.maybeNetworkUint64 else
            {
                return nil
            }

            limbs.append(limb)
        }

        guard data.isEmpty else
        {
            return nil
        }

        self.init(limbs: limbs)
    }
    
    public var maybeNetworkData: Data?
    {
        return self.varint
    }
    
    public var varint: Data?
    {
        var result: Data = Data()

        let count = self.limbs.count
        guard let countByte = UInt8(count).maybeNetworkData else
        {
            return nil
        }

        result.append(countByte)

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
