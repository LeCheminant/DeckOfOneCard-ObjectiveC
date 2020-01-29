//
//  DVMCardController.m
//  DeckOfOneCard-ObjectiveC
//
//  Created by Jacob LeCheminant on 1/28/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"

static NSString *const baseURLString = @"https://deckofcardsapi.com/api/deck/new/";
static NSString *const drawComponent = @"draw/";
static NSString *const countQueryName = @"count";

static NSString *const kcardsArray = @"cards";

@implementation DVMCardController

+ (void)drawANewCard:(NSNumber *)numberOfCards completion:(void (^)(NSArray<DVMCard *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *drawURL = [baseURL URLByAppendingPathComponent:drawComponent];
    
    NSString *cardCount = [numberOfCards stringValue];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL: drawURL resolvingAgainstBaseURL: true];
    
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:countQueryName value:cardCount];
    
    urlComponents.queryItems = @[queryItem];
    
    NSURL *searchURL = urlComponents.URL;
    
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching a card! %@", error);
            completion(nil);
        }
        
        if (!data) {
            NSLog(@"Error fetching card DATA! %@", error);
            completion(nil); return;
        }
        
        NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: 2 error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]){
            NSLog(@"Cannot create a dictionary");
            completion(nil);
            return;
        }
        
        NSArray * cardsArray = jsonDictionary[kcardsArray];
        
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary *cardDictionary in cardsArray)
        {
        
        DVMCard *card = [[DVMCard alloc] initWithDictionary:jsonDictionary];
        completion(card);
        }
        
    }] resume];
}


+(void)fetchCardImage:(DVMCard *)card completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.imageString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error: Something", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error: No data returned.");
            completion(nil);
            return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
        
    }]resume];
}


@end
