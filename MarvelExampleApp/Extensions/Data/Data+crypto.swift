//
//  Data+crypto.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    
    func md5() -> String? {
        var digest = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        self.withUnsafeBytes { (bytes : UnsafePointer<UInt8>) -> Void in
            digest.withUnsafeMutableBytes { (mutableBytes : UnsafeMutablePointer<UInt8>) -> Void in
                CC_MD5(bytes, CC_LONG(self.count), mutableBytes)
            }
        }
        
        return digest.hexString()
    }
    
    func hexString() -> String {
        let string = self.map{ String($0, radix:16) }.joined()
        return string
    }
    
}
