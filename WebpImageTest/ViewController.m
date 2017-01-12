//
//  ViewController.m
//  WebpImageTest
//
//  Created by 吴狄 on 17/1/12.
//  Copyright © 2017年 Leven. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image.contentMode=UIViewContentModeScaleAspectFit;
    
    CALayer *layer=[[CALayer alloc]init];
    layer.frame=CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 400);
    [self.view.layer addSublayer:layer];
    layer.contentsGravity=kCAGravityResizeAspect;
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];

    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:@"http://7xswdm.com1.z0.glb.clouddn.com/FtkvhZescCVRyejDsQa2khZSi0WL?imageMogr2/thumbnail/700x/quality/50/strip/format/webp"] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%.2lf",(float)(receivedSize/expectedSize));
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img=[UIImage sd_imageWithWebPData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [layer setContents:(id _Nullable)img.CGImage];
            });
            
        });
        
       
        
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
