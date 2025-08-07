Return-Path: <linux-kernel+bounces-758831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8992B1D456
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C31628202
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30F254876;
	Thu,  7 Aug 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4i1S7z0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC633243378
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555908; cv=none; b=HPQqbJRC+xjVb+mOlOJpT7Moj/mWQ2QR2O7QvtY9BOjvnFg8RhW4+ZdU7Md7Vf5YazlmDZI02if3pvDn6WcUyA6vu19cbPyPcbkLXYpZuW4zYb2FRHykNfzSqVGEI53oWoEZdkG9/S+yqDBTIxcbQfnoyk3Xw4e6Lr7mT/OhEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555908; c=relaxed/simple;
	bh=Z8juUoPKnzPVrOKAT2bg4L+pwxA3Dh5VzHaqon9AtdY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BSGXcSAndJpHRPg3hPLsGG9KM9qU+nqrb72vqDSW8Ez/UQuwCNDXEXDHGWjNFgP2/nyJIKlLzQUuLjvsb6PDzMqurEWDTMOT5CtXZE1gKH7rv+Su4+YsELL4z2H3ZfPtcMHcKXxBRgWYVMENtddnnAvssPKVbd3lCdfSsHWH83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4i1S7z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF30C4CEEB;
	Thu,  7 Aug 2025 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754555908;
	bh=Z8juUoPKnzPVrOKAT2bg4L+pwxA3Dh5VzHaqon9AtdY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=a4i1S7z08sK8aku7qzbi7wmNbi4FqPzUt5FTlSf2dqaMKdRhjru56Dhd7iSbmWZNe
	 R4dasbTCY5TIpttRvcLMEzdkJ4w/2u8MFPl0mYrLlqQg+GbfpwTZCfm4g9ngw3GSDB
	 p7U6WeFgj0kFPiqD+T+KxzXfGC3CQvLsgMyKeHP4TBK4inkJMpUzRj2/F9uqPe77pH
	 GYLEo0MwBnepe3ByTekS6X4zdRM1k17TZGf9oF2w6TdK0u+v+7mI7QfVdCR1YtjvYu
	 NvKm2n/B94fuwZTG7NyCTTaGOt2omobcRtz4ThsVbwrlfqFR1hPma0aRTWSZBB90U6
	 sc3teWMF04WPA==
Message-ID: <ee0b8b83-a368-4529-b25d-d3b1c6291648@kernel.org>
Date: Thu, 7 Aug 2025 16:38:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Add bggc_block_io to adjust the priority of
 BG_GC when issuing IO
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250805132208.486601-1-liaoyuanhong@vivo.com>
 <20250806070905.71012-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250806070905.71012-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 15:09, Liao Yuanhong wrote:
> Currently, we have encountered some issues while testing ZUFS. In
> situations near the storage limit (e.g., 50GB remaining), and after
> simulating fragmentation by repeatedly writing and deleting data, we found
> that application installation and startup tests conducted after idling for
> a few minutes take significantly longer several times that of traditional
> UFS. Tracing the operations revealed that the majority of I/Os were issued
> by background GC, which blocks normal I/O operations.
> 
> Under normal circumstances, ZUFS indeed requires more background GC and
> employs a more aggressive GC strategy. However, I aim to find a way to
> minimize the impact on regular I/O operations under these near-limit
> conditions. To address this, I have introduced a bggc_block_io feature,
> which controls the prioritization of background GC in the presence of I/Os.
> This switch can be adjusted at the framework level to implement different
> strategies. If set to ALL_IO_PRIOR, all background GC operations will be
> skipped during active I/O issuance. The default option remains consistent
> with the current strategy, ensuring no change in behavior.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> Changes in v2:
> 	Non ZUFS can also be adjusted through this option.
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
>  fs/f2fs/f2fs.h                          | 18 +++++++++++-------
>  fs/f2fs/super.c                         |  2 ++
>  fs/f2fs/sysfs.c                         |  9 +++++++++
>  4 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index bc0e7fefc39d..12fda11d4da5 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -883,3 +883,16 @@ Date:		June 2025
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
>  Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
>  		Default: 1
> +
> +What:		/sys/fs/f2fs/<disk>/bggc_block_io
> +Date:		August 2025
> +Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
> +Description:	Used to adjust the BG_GC priority when issuing IO, with a default value
> +		of 1.

Default value is 2 if CONFIG_BLK_DEV_ZONED is off?

Thanks,

> +
> +		==================  =============================================
> +		value				description
> +		bggc_block_io = 0   Prioritize background GC
> +		bggc_block_io = 1   Stop background GC only when issuing read I/O
> +		bggc_block_io = 2   Stop background GC when issuing I/O
> +		==================  =============================================
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46be7560548c..fe41b733fbc2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
>  	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
>  };
>  
> +enum bggc_block_io_policy {
> +	BGGC_PRIOR,
> +	READ_IO_PRIOR,
> +	ALL_IO_PRIOR,
> +};
> +
>  /*
>   * An implementation of an rwsem that is explicitly unfair to readers. This
>   * prevents priority inversion when a low-priority reader acquires the read lock
> @@ -1804,6 +1810,7 @@ struct f2fs_sb_info {
>  	spinlock_t dev_lock;			/* protect dirty_device */
>  	bool aligned_blksize;			/* all devices has the same logical blksize */
>  	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
> +	unsigned int bggc_block_io;		/* For adjust the BG_GC priority when issuing IO */
>  
>  	/* For write statistics */
>  	u64 sectors_written_start;
> @@ -2998,13 +3005,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  	if (sbi->gc_mode == GC_URGENT_HIGH)
>  		return true;
>  
> -	if (zoned_gc) {
> -		if (is_inflight_read_io(sbi))
> -			return false;
> -	} else {
> -		if (is_inflight_io(sbi, type))
> -			return false;
> -	}
> +	if (sbi->bggc_block_io == READ_IO_PRIOR && is_inflight_read_io(sbi))
> +		return false;
> +	if (sbi->bggc_block_io == ALL_IO_PRIOR && is_inflight_io(sbi, type))
> +		return false;
>  
>  	if (sbi->gc_mode == GC_URGENT_MID)
>  		return true;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e16c4e2830c2..a21cecc5424e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4629,9 +4629,11 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  
>  	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>  	sbi->aligned_blksize = true;
> +	sbi->bggc_block_io = ALL_IO_PRIOR;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	sbi->max_open_zones = UINT_MAX;
>  	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
> +	sbi->bggc_block_io = READ_IO_PRIOR;
>  #endif
>  
>  	for (i = 0; i < max_devices; i++) {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f736052dea50..efea15209788 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -674,6 +674,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		sbi->blkzone_alloc_policy = t;
>  		return count;
>  	}
> +
> +	if (!strcmp(a->attr.name, "bggc_block_io")) {
> +		if (t < BGGC_PRIOR || t > ALL_IO_PRIOR)
> +			return -EINVAL;
> +		sbi->bggc_block_io = t;
> +		return count;
> +	}
>  #endif
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -1172,6 +1179,7 @@ F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
>  F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
> +F2FS_SBI_GENERAL_RW_ATTR(bggc_block_io);
>  #endif
>  F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>  F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
> @@ -1342,6 +1350,7 @@ static struct attribute *f2fs_attrs[] = {
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	ATTR_LIST(unusable_blocks_per_sec),
>  	ATTR_LIST(blkzone_alloc_policy),
> +	ATTR_LIST(bggc_block_io),
>  #endif
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	ATTR_LIST(compr_written_block),


