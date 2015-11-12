//
//  ArtistResult.h
//  ArtistSearch
//
//  Created by Brent Dady on 11/11/15.
//  Copyright © 2015 Brent Dady. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ArtistResult : NSObject

@property NSString *artistName;
@property NSString *trackName;
@property NSString *collectionName;
@property NSString *previewUrl;
@property NSString *artworkUrl100;
@property NSString *collectionViewUrl;
@property NSNumber *collectionPrice;
@property NSNumber *trackPrice;

- (instancetype)initWithName:(NSString *)artistName track:(NSString *)trackName collection:(NSString *)collectionName preview:(NSString *)previewUrl artwork:(NSString *)artworkUrl100 collection:(NSString *)collectionViewUrl cPrice:(NSNumber *)collectionPrice tPrice:(NSNumber *)trackPrice;

@end
