//
//  ViewController.m
//  happykomosama
//
//  Created by ohta tomotaka on 2014/05/05.
//  Copyright (c) 2014年 ohta tomotaka. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#include <AVFoundation/AVFoundation.h>
#import "SuViewController.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic) BOOL cellColor;
@property (nonatomic, retain) AVAudioPlayer *player;
@end

@implementation ViewController{
    NSString *selectedName;
    NSArray *array;
    int count;
    NSMutableData * receivedData;
    AVAudioPlayer *player;
    int select;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"call TL");
    NSError* error;
    NSString *sid2= [NSString stringWithFormat:@"http://arcane-brushlands-5020.herokuapp.com/messages.json"];
    
    NSURL *url = [NSURL URLWithString:sid2];
    NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *jsondata = [response dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    array = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%lu",(unsigned long)[array count]);
    count = [array count];
}
#pragma mark - tableview
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;	// 0 -> 1 に変更
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return count;	// 0 -> 10 に変更
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row]; // 何番目のセルかを表示させました
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    int sec = indexPath.row;
//    NSURL *theURL = [NSURL URLWithString:[self namej:sec]];
//    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
//    NSURLRequest *theRequest=[NSURLRequest requestWithURL:theURL];
//    NSURLConnection *theConnection=[[NSURLConnection alloc]
//                                    initWithRequest:theRequest delegate:self];
//    if (theConnection) {
//        NSLog(@"start loading");
//        receivedData = [NSMutableData data];
//    }
//    select=indexPath.row;
//}


-(NSString*)url:(int)row{
    int i = row;
    NSDictionary *jsonDic1 = [array objectAtIndex:i];
    NSString *url = [jsonDic1 objectForKey:@"url"];
    if ( [url isEqual:[NSNull null]] ){
        NSLog(@"空です");
        url=@"MacBook_005.png";
    }
    return url;
}
-(NSString*)imagepath:(int)row{
    int i = row;
    NSDictionary *jsonDic1 = [array objectAtIndex:i];
    NSString *path = [jsonDic1 objectForKey:@"image"];
    if ( [path isEqual:[NSNull null]] ){
        NSLog(@"image空です");
        path=@"http://temper.moo.jp/catk/no_image.jpg";
    }
    return path;
}
-(NSString*)name:(int)row{
    int i = row;
    NSDictionary *jsonDic1 = [array objectAtIndex:i];
    NSString *name = [jsonDic1 objectForKey:@"name"];
    if ( [name isEqual:[NSNull null]] ){
        NSLog(@"name空です");
        name=@"名前無しさん";
    }
    return name;
}
-(NSString*)group:(int)row{
    int i = row;
    NSDictionary *jsonDic1 = [array objectAtIndex:i];
    NSString *name = [jsonDic1 objectForKey:@"organization"];
    if ( [name isEqual:[NSNull null]] ){
        NSLog(@"name空です");
        name=@"";
    }
    return name;
}

#pragma mark - colletionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    NSLog(@"index %d",indexPath.row);
    
    
    NSLog(@"index %@",[self imagepath:indexPath.row]);
    NSString *test = [self imagepath:indexPath.row];
    NSLog(@"finish insert test");
    
    if ( [test isEqual:[NSNull null]] ){
        NSLog(@"空です");
        test=@"MacBook_005.png";
    }
    NSLog(@"no null");
//    NSString *URLString =test;
//	NSURL *url = [NSURL URLWithString:URLString];
//	NSData *data = [NSData dataWithContentsOfURL:url];
//	UIImage *image = [[UIImage alloc] initWithData:data];
//    imageView.image = image;
    
    NSURL *imageURL = [NSURL URLWithString:test];
    UIImage *placeholderImage = [UIImage imageNamed:@"画像読み込み完了までに表示するリソース画像"];
    [imageView setImageWithURL:imageURL
               placeholderImage:placeholderImage];
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text = [NSString stringWithFormat:[self name:indexPath.row]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    SuViewController *ViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"sub"];
    ViewController2.imagepath=[self imagepath:indexPath.row];
    ViewController2.snamelabel=[self name:indexPath.row];
    ViewController2.sgrouplabel=[self group:indexPath.row];
    ViewController2.voicepath=[self url:indexPath.row];
    [self presentViewController:ViewController2 animated:YES completion:nil];
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSLog(@"select %d",indexPath.row);
//    int sec = indexPath.row;
//    NSURL *theURL = [NSURL URLWithString:[self url:sec]];
//    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
//    NSURLRequest *theRequest=[NSURLRequest requestWithURL:theURL];
//    NSURLConnection *theConnection=[[NSURLConnection alloc]
//                                    initWithRequest:theRequest delegate:self];
//    if (theConnection) {
//        NSLog(@"start loading");
//        receivedData = [NSMutableData data];
//    }
//    select=indexPath.row;


}

@end
