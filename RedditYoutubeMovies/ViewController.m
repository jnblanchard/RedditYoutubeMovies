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
#import "TFHppleElement.h"
#import "InfoCell.h"

#define urlRedditString @"https://www.reddit.com/r/fullmoviesonyoutube"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *allElements;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TFHpple* redditParser = [TFHpple hppleWithHTMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlRedditString]]];
    NSMutableArray* titleArray = [NSMutableArray arrayWithArray:[redditParser searchWithXPathQuery:@"//p[@class=\"title\"]"]];
    

    _allElements = [[NSMutableArray alloc] init];

    for (TFHppleElement *element in titleArray) {
        InfoCell *infoCell = [[InfoCell alloc] init];
        [infoCell setTitleElement:[[[element children] objectAtIndex:1] content]];
        [infoCell setUrlElement:[[[element children] objectAtIndex:1] objectForKey:@"data-outbound-url"]];
        [_allElements addObject:infoCell];
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allElements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    [[cell textLabel] setText:[[_allElements objectAtIndex:[indexPath row]] titleElement]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"vid" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YoutubePlayerViewController* ypvc = (YoutubePlayerViewController*)segue.destinationViewController;
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    [ypvc setYtID:[[_allElements objectAtIndex:[selectedRow row]] urlElement]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
