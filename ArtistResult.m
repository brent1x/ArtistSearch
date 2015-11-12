//
//  ArtistResult.m
//  ArtistSearch
//
//  Created by Brent Dady on 11/11/15.
//  Copyright © 2015 Brent Dady. All rights reserved.
//

#import "ArtistResult.h"

@implementation ArtistResult

- (instancetype)initWithName:(NSString *)artistName track:(NSString *)trackName collection:(NSString *)collectionName preview:(NSString *)previewUrl artwork:(NSString *)artworkUrl100 collection:(NSString *)collectionViewUrl cPrice:(NSNumber *)collectionPrice tPrice:(NSNumber *)trackPrice {

    self = [super init];
    self.artistName = artistName;
    self.trackName = trackName;
    self.collectionName = collectionName;
    self.previewUrl = previewUrl;
    self.artworkUrl100 = artworkUrl100;
    self.collectionViewUrl = collectionViewUrl;
    self.collectionPrice = collectionPrice;
    self.trackPrice = trackPrice;

    return self;
}

@end
