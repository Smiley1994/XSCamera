//
//  XSCaptureFiltersView.m
//  XSCamera
//
//  Created by 晓松 on 2019/2/26.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSCaptureFiltersView.h"
#import "XSFilterItemCell.h"
#import "Masonry.h"
#import "XSUIMacro.h"

@interface XSCaptureFiltersView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat filterCellHeight;

@end

static CGFloat const EDGE_PADDING = 10;

@implementation XSCaptureFiltersView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.filterCellHeight = CAPTURE_BOTTOM_VIEW_HEIGHT - CAPTURE_BOTTOM_VIEW_TOP_PADDING - CAPTURE_BOTTOM_VIEW_BOTTOM_PADDING;
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"滤镜";
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = HEXCOLOR(0x18cdfa);
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset (EDGE_PADDING);
        make.top.equalTo(self.mas_top).offset(13);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xE5E5E5);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(EDGE_PADDING);
        make.right.equalTo(self.mas_right).inset(EDGE_PADDING);
        make.top.equalTo(self.mas_top).offset(CAPTURE_BOTTOM_VIEW_TOP_PADDING - 7);
        make.height.mas_equalTo(0.5);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[XSFilterItemCell class] forCellWithReuseIdentifier:XSFilterItemCellId];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(EDGE_PADDING);
        make.right.equalTo(self.mas_right).inset(EDGE_PADDING);
        make.top.equalTo (self.mas_top).offset(CAPTURE_BOTTOM_VIEW_TOP_PADDING);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    } else {
        return CGSizeMake(10, self.filterCellHeight);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = UIColor.whiteColor;
        return view;
    } else {
        return nil;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.filterCellHeight - 25, self.filterCellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSFilterItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSFilterItemCellId forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XSFilterModel *model = self.dataArray[indexPath.row];
    for (XSFilterModel *model in self.dataArray) {
        if (model.index == indexPath.row) {
            model.selected = 1;
        } else {
            model.selected = 0;
        }
    }
    
    [self.collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(selectedFilterWithIndex:)]) {
        [self.delegate selectedFilterWithIndex:indexPath.row];
    }
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
