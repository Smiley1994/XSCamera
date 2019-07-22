//
//  XSPhotoAlbumViewController.m
//  XSCamera
//
//  Created by 晓松 on 2019/3/5.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSPhotoAlbumViewController.h"
#import "XSPhotoEditViewController.h"
#import "XSPhotoCollectionViewCell.h"
#import "XSPhotoAlbumNaviagtionView.h"
#import <Photos/Photos.h>
#import "XSPHAsset.h"
#import "XSAlbumModel.h"
#import "Masonry.h"
#import "XSUIMacro.h"
#import "XSUtils.h"

@interface XSPhotoAlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, XSPhotoAlbumNavigationDelegate>

@property (nonatomic, strong) UICollectionView *photosCollectionView;
@property (nonatomic, strong) NSMutableArray *photosDataArray;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *assets;
@property (nonatomic, strong) PHImageRequestOptions *options;


@end

static CGFloat const SPACING = 3;

@implementation XSPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    self.view.backgroundColor = UIColor.whiteColor;
    self.photosDataArray = [[NSMutableArray alloc] init];
    
//    [self setupSystemPhotos];
    [self setupAssets];
    [self createCollectionView];
    [self createNavigationView];
    
}

- (void)createNavigationView {
    XSPhotoAlbumNaviagtionView *navigationView = [[XSPhotoAlbumNaviagtionView alloc] init];
    navigationView.backgroundColor = RGBA(244, 244, 244, 0.7);
    navigationView.delegate = self;
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_HEIGHT);
    }];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = SPACING;
    layout.minimumInteritemSpacing = SPACING;
    self.photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.photosCollectionView.delegate = self;
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.backgroundColor = UIColor.whiteColor;
    self.photosCollectionView.contentInset = UIEdgeInsetsMake(NAVIGATION_HEIGHT - 22, SPACING, 0, SPACING);
    [self.photosCollectionView registerClass:[XSPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    [self.view addSubview:self.photosCollectionView];
    [self.photosCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_HEIGHT);
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)setupAssets {
    self.options = [[PHImageRequestOptions alloc] init];
    self.options.resizeMode = PHImageRequestOptionsResizeModeFast;
//    self.options.deliveryMode
    self.options.synchronous = NO;
    
    self.assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    [self.photosCollectionView reloadData];
}

- (void)setupSystemPhotos {
    
    __weak typeof(self) weakSelf = self;
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    __block NSArray<XSPHAsset *> *assets;
    __block XSAlbumModel *xs_albumModel;
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *  _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (collection.assetCollectionSubtype != 202 && collection.assetCollectionSubtype < 212) {
            //获取所有照片
            assets = [strongSelf setupAssetsInAssetCollection:collection ascending:NO];
            if (assets.count > 0) {
                xs_albumModel = [[XSAlbumModel alloc] init];
                NSLog(@"相簿名:%@", collection.localizedTitle);
                xs_albumModel.title = collection.localizedTitle;
                xs_albumModel.assets = assets;
                xs_albumModel.assetCollection = collection;
                xs_albumModel.count = assets.count;
                [strongSelf.photosDataArray addObject:xs_albumModel];
            }
        }
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.photosCollectionView reloadData];
    });
}

- (NSMutableArray<XSPHAsset *> *)setupAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    
    NSMutableArray<XSPHAsset *> *array = [[NSMutableArray alloc] init];
    __block XSPHAsset *xs_asset;
    PHFetchResult *result = [self fetchAssetInAssetCollection:assetCollection ascending:ascending];
    [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.mediaType == PHAssetMediaTypeImage) {
            xs_asset = [[XSPHAsset alloc] init];
            xs_asset.asset = obj;
            [array addObject:xs_asset];
        } else {
            NSLog(@"NO PHAssetMediaTypeImage");
        }
    }];
    return array;
}

- (PHFetchResult *)fetchAssetInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return result;
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 4;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.assets.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - SPACING * 5) / 4, (SCREEN_WIDTH - SPACING * 5) / 3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSPhotoCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.redColor;
//    [[PHImageManager defaultManager] requestImageDataForAsset:self.assets[indexPath.row] options:self.options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//
//        cell.imageView.image = [[UIImage alloc] initWithData:imageData];
//    }];
    
    [[PHImageManager defaultManager] requestImageForAsset:self.assets[indexPath.row] targetSize:CGSizeMake((SCREEN_WIDTH - SPACING * 5) / 4, (SCREEN_WIDTH - SPACING * 5) / 3) contentMode:PHImageContentModeDefault options:self.options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.imageView.image = result;
    }];
//
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    XSPhotoEditViewController *edit = [[XSPhotoEditViewController alloc] init];
//    [self.navigationController pushViewController:edit animated:YES];
}


- (void)close {
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finish {
    
}

@end
