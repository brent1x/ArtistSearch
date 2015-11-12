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
@property (weak, nonatomic) IBOutlet UIButton *buySongButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = self.result.artistName;

    self.songTitle.text = [NSString stringWithFormat:@"Track: %@", self.result.trackName];
    self.songPrice.text = [NSString stringWithFormat:@"$%@", [self.result.trackPrice stringValue]];

    self.collectionTitle.text = [NSString stringWithFormat:@"Album: %@", self.result.collectionName];
    self.collectionPrice.text = [NSString stringWithFormat:@"$%@", [self.result.collectionPrice stringValue]];

    NSURL *artworkUrl = [NSURL URLWithString:self.result.artworkUrl100];
    self.albumArt.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:artworkUrl]];

}

- (IBAction)onBuyTrackPressed:(id)sender {
    NSLog(@"%@", self.result.trackViewUrl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.result.trackViewUrl]];
}

@end