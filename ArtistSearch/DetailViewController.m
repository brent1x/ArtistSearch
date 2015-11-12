//
//  DetailViewController.m
//  ArtistSearch
//
//  Created by Brent Dady on 11/11/15.
//  Copyright © 2015 Brent Dady. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UILabel *songPrice;
@property (weak, nonatomic) IBOutlet UILabel *collectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *collectionPrice;
@property (weak, nonatomic) IBOutlet UIImageView *albumArt;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.result.artistName;

    self.songTitle.text = self.result.trackName;
    self.songPrice.text = [self.result.trackPrice stringValue];

    self.collectionTitle.text = self.result.collectionName;
    self.collectionPrice.text = [self.result.collectionPrice stringValue];

    NSURL *aURL = [NSURL URLWithString:self.result.artworkUrl100];

    self.albumArt.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:aURL]];

}

@end