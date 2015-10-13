//
//  EnterpriseProperties.swift
//  Wall Invest
//
//  Created by Henrique do Prado Linhares on 05/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation


class EnterpriseProperties{

    var enterprises:[Enterprise]
    

    init(){
        self.enterprises = [Enterprise]()
        
        let ent1desc = "Fundada em 1931, na Arábia Saudita, é a maior empresa de petróleo do mundo responsável pela venda de cerca de 400 barris de petróleo para os Estados Unidos"
        let ent1 = Enterprise(pId: 1, pName: "Everest Oil", pValue: 180000000000, pDescription: ent1desc, pImageName: "everestOil.png")
        self.enterprises.append(ent1)
        
        
        
        
    
    }



}