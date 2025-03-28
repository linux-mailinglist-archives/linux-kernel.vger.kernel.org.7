Return-Path: <linux-kernel+bounces-579411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA40A742CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 04:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905421796DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 03:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB321147B;
	Fri, 28 Mar 2025 03:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAorpbq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA6211462
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743132586; cv=none; b=RHR1fiDM3j88lVwkI10xb6nRJzOLBGC/UHdHiOdTH/7G3wxXfAfFFUJlxBHG/XYWW61JFfKKumMIfu5ou7408MsbfF14hx+k6k33Tkpx8KKlsPhE6a9UXvjnGo16ShP/2KNc7+UyXX/c1yCd5d265SjOWPVUfq8EnNkrSDxdHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743132586; c=relaxed/simple;
	bh=fFHh/7o5dVm+ZWv7/WGLvJs+KgMMTP4llLeLOFEYEVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kChVYli+dk09AclCXbys3X4lfT6Sm2Y4r2zBe49ZWil5obhtOhnrky9zRCXmT+2vTsmbQzpVsTafhgdVnSGlUTFA5i+0Wkdmh8riEMu+7Vb8wJPaqO4RQqABdjfTAhlnpMocLzvX3lU7TeR63Bm4W2T0BktsgiD4SGIRXxjM3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAorpbq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C50C4CEDD;
	Fri, 28 Mar 2025 03:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743132586;
	bh=fFHh/7o5dVm+ZWv7/WGLvJs+KgMMTP4llLeLOFEYEVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oAorpbq28XkkI2Dp2iR+VZdQOb0oqdrOxk7WjqCNo0z8LpXPphVbxHONeQQsVY0O9
	 w8GAVuureAjqfv8BN1b+yBnUh/8L6EA7ncXKzX4OWgU9fJK1amWEPSoIVVzo7zZlBl
	 6cESQiQvaMg47G0rxZWVfx4+JYc4lZG6Z8yFC+MIrAKYBgrITHXPXGxZOLxwCNJpUx
	 zQSIvrNKhs8kzpKdpLpMw7wELBKuaV5AIGuskgS9L3rW0BQ0t5Ykl8YTUXZ5XG6mgN
	 hw1iDxCZ9j7InszfHE83oeRcjNv+zHhkyxnEMaGuT197ExUZZH0gKwCZYjqqr/As5R
	 xz+G5iRpQPoxw==
Date: Fri, 28 Mar 2025 03:29:44 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v2 1/2] f2fs: zone: fix to calculate first_zoned_segno
 correctly
Message-ID: <Z-YXqKOIgYCpfuL0@google.com>
References: <20250325080646.3291947-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325080646.3291947-1-chao@kernel.org>

It seems this patch breaks the multi-partition cases.

On 03/25, Chao Yu wrote:
> A zoned device can has both conventional zones and sequential zones,
> so we should not treat first segment of zoned device as first_zoned_segno,
> instead, we need to check zone type for each zone during traversing zoned
> device to find first_zoned_segno.
> 
> Otherwise, for below case, first_zoned_segno will be 0, which could be
> wrong.
> 
> create_null_blk 512 2 1024 1024
> mkfs.f2fs -m /dev/nullb0
> 
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - traverse w/ zone unit in get_first_zoned_segno()
>  fs/f2fs/f2fs.h    | 18 +++++++++++++-----
>  fs/f2fs/segment.c |  2 +-
>  fs/f2fs/super.c   | 37 +++++++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ca884e39a5ff..3dea037faa55 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4630,12 +4630,16 @@ F2FS_FEATURE_FUNCS(readonly, RO);
>  F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> -static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> -				    block_t blkaddr)
> +static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
> +							unsigned int zone)
>  {
> -	unsigned int zno = blkaddr / sbi->blocks_per_blkz;
> +	return test_bit(zone, FDEV(devi).blkz_seq);
> +}
>  
> -	return test_bit(zno, FDEV(devi).blkz_seq);
> +static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> +								block_t blkaddr)
> +{
> +	return f2fs_zone_is_seq(sbi, devi, blkaddr / sbi->blocks_per_blkz);
>  }
>  #endif
>  
> @@ -4711,9 +4715,13 @@ static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
>  					  block_t blkaddr)
>  {
>  	if (f2fs_sb_has_blkzoned(sbi)) {
> +#ifdef CONFIG_BLK_DEV_ZONED
>  		int devi = f2fs_target_device_index(sbi, blkaddr);
>  
> -		return !bdev_is_zoned(FDEV(devi).bdev);
> +		return !f2fs_blkz_is_seq(sbi, devi, blkaddr);
> +#else
> +		return true;
> +#endif
>  	}
>  	return true;
>  }
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 396ef71f41e3..dc360b4b0569 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3311,7 +3311,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
>  
>  	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
>  		f2fs_down_write(&sbi->gc_lock);
> -		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
> +		err = f2fs_gc_range(sbi, 0, sbi->first_zoned_segno - 1,
>  				true, ZONED_PIN_SEC_REQUIRED_COUNT);
>  		f2fs_up_write(&sbi->gc_lock);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 011925ee54f8..9a42a1323f42 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4307,12 +4307,33 @@ static void f2fs_record_error_work(struct work_struct *work)
>  
>  static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sbi)
>  {
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	unsigned int zoneno, total_zones;
>  	int devi;
>  
> -	for (devi = 0; devi < sbi->s_ndevs; devi++)
> -		if (bdev_is_zoned(FDEV(devi).bdev))
> -			return GET_SEGNO(sbi, FDEV(devi).start_blk);
> -	return 0;
> +	if (!f2fs_sb_has_blkzoned(sbi))
> +		return NULL_SEGNO;
> +
> +	for (devi = 0; devi < sbi->s_ndevs; devi++) {
> +		if (!bdev_is_zoned(FDEV(devi).bdev))
> +			continue;
> +
> +		total_zones = GET_ZONE_FROM_SEG(sbi, FDEV(devi).total_segments);
> +
> +		for (zoneno = 0; zoneno < total_zones; zoneno++) {
> +			unsigned int segs, blks;
> +
> +			if (!f2fs_zone_is_seq(sbi, devi, zoneno))
> +				continue;
> +
> +			segs = GET_SEG_FROM_SEC(sbi,
> +					zoneno * sbi->secs_per_zone);
> +			blks = SEGS_TO_BLKS(sbi, segs);
> +			return GET_SEGNO(sbi, FDEV(devi).start_blk + blks);
> +		}
> +	}
> +#endif
> +	return NULL_SEGNO;
>  }
>  
>  static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
> @@ -4349,6 +4370,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  #endif
>  
>  	for (i = 0; i < max_devices; i++) {
> +		if (max_devices == 1) {
> +			FDEV(i).total_segments =
> +				le32_to_cpu(raw_super->segment_count_main);
> +			FDEV(i).start_blk = 0;
> +			FDEV(i).end_blk = FDEV(i).total_segments *
> +						BLKS_PER_SEG(sbi);
> +		}
> +
>  		if (i == 0)
>  			FDEV(0).bdev_file = sbi->sb->s_bdev_file;
>  		else if (!RDEV(i).path[0])
> -- 
> 2.48.1

