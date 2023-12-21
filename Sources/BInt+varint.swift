//
//  BInt+varint.swift
//
//
//  Created by Dr. Brandon Wiley on 12/19/23.
//

import Foundation

import Datable

extension BInt
{
    public init?(varint: Data)
    {
        var data = varint
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

    public var varint: Data
    {
        if self.isZero()
        {
            return Data(array: [0x00])
        }

        var result: Data = Data()

        var count = self.limbs.count * 8

        var limbData: Data = Data()
        for limb in self.limbs
        {
            limbData.append(limb.maybeNetworkData!)
        }

        while true
        {
            if let first = limbData.first, first == 0
            {
                limbData = limbData.dropFirst()
                count -= 1
            }
            else
            {
                break
            }
        }

        let countByte = UInt8(count).maybeNetworkData!
        result.append(countByte)
        result.append(limbData)

        return result
    }
}
