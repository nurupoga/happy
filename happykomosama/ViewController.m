//
//  ViewController.m
//  happykomosama
//
//  Created by ohta tomotaka on 2014/05/05.
//  Copyright (c) 2014年 ohta tomotaka. All rights reserved.
//

#import "ViewController.h"
#include <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, retain) AVAudioPlayer *player;
@end

@implementation ViewController{
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;	// 0 -> 1 に変更
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count;	// 0 -> 10 に変更
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row]; // 何番目のセルかを表示させました
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    int sec = indexPath.row;
    NSURL *theURL = [NSURL URLWithString:[self namej:sec]];
    //http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:theURL];
    NSURLConnection *theConnection=[[NSURLConnection alloc]
                                    initWithRequest:theRequest delegate:self];
    if (theConnection) {
        NSLog(@"start loading");
        receivedData = [NSMutableData data];
    }
    select=indexPath.row;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"voice%d.mp3",select];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    
//    NSString *soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"whistle1"
//                                    ofType: @"mp3"];
    

    
    [receivedData writeToFile:filePath atomically:YES];
    //[connection release];
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    

}
- (IBAction)sample:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"voice%d.mp3",select];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    SystemSoundID sound;
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"answer3" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound);
    
    // サウンドの再生
    AudioServicesPlaySystemSound(sound);
}
-(NSString*)namej:(int)row{
    int i = row;
    NSDictionary *jsonDic1 = [array objectAtIndex:i];
    NSString *name = [jsonDic1 objectForKey:@"url"];
    return name;
}
@end
