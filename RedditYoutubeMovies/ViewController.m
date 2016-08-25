//
//  ViewController.m
//  RedditYoutubeMovies
//
//  Created by John N Blanchard on 8/25/16.
//  Copyright © 2016 John N Blanchard. All rights reserved.
//

#import "ViewController.h"
@import JavaScriptCore;
#import "TFHpple.h"
#import "YoutubePlayerViewController.h"

#define urlRedditString @"https://www.reddit.com/r/fullmoviesonyoutube"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TFHpple* redditParser = [TFHpple hppleWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlRedditString]]];
    NSMutableArray* titleArray = [NSMutableArray arrayWithArray:[redditParser searchWithXPathQuery:@"//p[@class=\"title\"]"]];
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YoutubePlayerViewController* ypvc = (YoutubePlayerViewController*)segue.destinationViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
