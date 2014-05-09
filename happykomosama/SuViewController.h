//
//  SuViewController.h
//  happykomosama
//
//  Created by ohta tomotaka on 2014/05/08.
//  Copyright (c) 2014年 ohta tomotaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuViewController : UIViewController{
    IBOutlet UIImageView *topimage;
    IBOutlet UILabel *namelabel;
    IBOutlet UILabel *grouplabel;
}
@property NSString* imagepath;
@property NSString* snamelabel;
@property NSString* sgrouplabel;
@property NSString* voicepath;
-(IBAction)select;
@end
