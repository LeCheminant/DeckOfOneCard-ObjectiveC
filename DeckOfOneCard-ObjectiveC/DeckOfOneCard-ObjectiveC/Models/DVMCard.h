//
//  DVMCard.h
//  DeckOfOneCard-ObjectiveC
//
//  Created by Jacob LeCheminant on 1/28/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString * suit;
@property (nonatomic, copy, readonly) NSString * imageString;

- (instancetype) initWithSuit:(NSString *)suit
                  imageString:(NSString *)imageString

NS_DESIGNATED_INITIALIZER;

@end

@interface DVMCard (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
