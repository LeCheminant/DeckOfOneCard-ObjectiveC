//
//  DVMCard.m
//  DeckOfOneCard-ObjectiveC
//
//  Created by Jacob LeCheminant on 1/28/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

@end

- (instancetype)initWithSuit:(NSString *)suit imageString:(NSString *)imageString
{
    self = [super init];
    if (self) {
        _suit = [suit copy];
        _imageString = [imageString copy];
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[@"suit"];
    NSString *imageString = dictionary[@"imageString"];
    
    return [self initWithSuit:suit imageString:imageString];
}

@end

