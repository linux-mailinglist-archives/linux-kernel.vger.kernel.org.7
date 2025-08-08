Return-Path: <linux-kernel+bounces-759949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09BB1E4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3EB4E3DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5EB2690ED;
	Fri,  8 Aug 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6aZEtRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7B26B76F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643087; cv=none; b=QJq8BooGzVY0Rz3JIK1qJxBoPNDwlQsP4qSgBBGh5bTF/mZGN2CZV5sw6Xa6wsEqRWTz4yolysNa+D2ggabMzkOrYVtACDfcuvlBwzQDRHBU/SllHd5e0AVPxEVA5biugwuxZzCPOAWJ1eEdxTwvy4ZHkWRaaJ6OaHhId450+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643087; c=relaxed/simple;
	bh=IWdk99tmWxi7aajaTzmcpHaOK5XzjNsTEpbOhip9jIU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iNkbLw52ytN2puZMHyT39wchkXeTZv6U+x6khzvstySrmbu15aNu9t0KFynDdyOWtd5eH5LNY0yGqoz1v2JOlioJqkEnGgRWHli0Ax1r9GvqIPvHaFADOaWu77V34g3BPMppolPjauF/ZW2pm3lsmh2zWESJY0M5myQvDBuhcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6aZEtRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7334C4CEF0;
	Fri,  8 Aug 2025 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754643086;
	bh=IWdk99tmWxi7aajaTzmcpHaOK5XzjNsTEpbOhip9jIU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=l6aZEtRR49R+PLKwbzr3hjlIwS9hePRbkslFmO0ZBTfoJwVa6cjKxliuuFPVjEb9w
	 e8VW0XneI8BSl9A4Vej3oBPhrG/LFt3tDQnGg9gvdWgKQMGKrXo+rVf2RIqyEENW7B
	 3zP7V3kehDxr9fvgDH/hAmbu57xZbic31R45u5aUOJWAW1p8RWDfM+1Ks3uVLBUkiK
	 84JgVtiyXQH9MvEGkj0b4SXRfstG5rPUpirlH4rEzBruGqlT5ESo2B4CAP4WtBYfWH
	 zEWdCYvBa7vCMvVXLqix2GCOBK8kMoNAgFtohdX/0aPUV2eNySjNsBJdz7ld4jzVP6
	 NgsliN8tLJqzA==
Message-ID: <459de7d9-970a-4921-b16d-d8ee658f86a8@kernel.org>
Date: Fri, 8 Aug 2025 16:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] f2fs: Add bggc_block_io to adjust the priority of
 BG_GC when issuing IO
To: Liao Yuanhong <liaoyuanhong@vivo.com>, jaegeuk@kernel.org
References: <20250808072939.202357-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250808072939.202357-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/2025 3:29 PM, Liao Yuanhong wrote:
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
> Changes in v4:
> 	Adjust the default policy ALL_IO_PRIOR to 0 and modify the description to
> 	match this change
> 
> Changes in v3:
> 	Modified the issue where it does not work after closing
> 	CONFIG_BLK_DEV_ZONED.
> 
> Changes in v2:
> 	Non ZUFS can also be adjusted through this option.
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
>   fs/f2fs/f2fs.h                          | 18 +++++++++++-------
>   fs/f2fs/super.c                         |  2 ++
>   fs/f2fs/sysfs.c                         |  9 +++++++++
>   4 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index bc0e7fefc39d..21e6951919de 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -883,3 +883,16 @@ Date:		June 2025
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
>   		Default: 1
> +
> +What:		/sys/fs/f2fs/<disk>/bggc_block_io
> +Date:		August 2025
> +Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
> +Description:	Used to adjust the BG_GC priority when issuing IO, with a default value
> +		of 0. Specifically, for ZUFS, the default value is 1.
> +
> +		==================  =============================================
> +		value				description
> +		bggc_block_io = 0   Stop background GC when issuing I/O
> +		bggc_block_io = 1   Stop background GC only when issuing read I/O
> +		bggc_block_io = 2   Prioritize background GC
> +		==================  =============================================
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 46be7560548c..440542ea0646 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
>   	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
>   };
>   
> +enum bggc_block_io_policy {
> +	ALL_IO_PRIOR,
> +	READ_IO_PRIOR,
> +	BGGC_PRIOR,

Hi Yuanhong,

Just nitpick, :)

A little bit confuse for BGGC_PRIOR naming, since it won't submit
bggc IO in prior to other IO, just not be aware other IOs.

So, what do you think of renaming as below? Keeping align w/ naming
of discard_policy.io_aware.

/sys/fs/f2fs/<dev>/bggc_io_aware

enum bggc_io_aware_policy {
	AWARE_ALL_IO,		/* skip background GC if there is any kind of pending IO */
	AWARE_READ_IO,		/* skip background GC if there is pending read IO */
	AWARE_NONE,		/* don't aware IO for background GC */
};

Thanks,

> +};
> +
>   /*
>    * An implementation of an rwsem that is explicitly unfair to readers. This
>    * prevents priority inversion when a low-priority reader acquires the read lock
> @@ -1804,6 +1810,7 @@ struct f2fs_sb_info {
>   	spinlock_t dev_lock;			/* protect dirty_device */
>   	bool aligned_blksize;			/* all devices has the same logical blksize */
>   	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
> +	unsigned int bggc_block_io;		/* For adjust the BG_GC priority when issuing IO */
>   
>   	/* For write statistics */
>   	u64 sectors_written_start;
> @@ -2998,13 +3005,10 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>   	if (sbi->gc_mode == GC_URGENT_HIGH)
>   		return true;
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
>   	if (sbi->gc_mode == GC_URGENT_MID)
>   		return true;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e16c4e2830c2..a21cecc5424e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4629,9 +4629,11 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>   
>   	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>   	sbi->aligned_blksize = true;
> +	sbi->bggc_block_io = ALL_IO_PRIOR;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	sbi->max_open_zones = UINT_MAX;
>   	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
> +	sbi->bggc_block_io = READ_IO_PRIOR;
>   #endif
>   
>   	for (i = 0; i < max_devices; i++) {
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f736052dea50..1b587908f049 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -866,6 +866,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "bggc_block_io")) {
> +		if (t < ALL_IO_PRIOR || t > BGGC_PRIOR)
> +			return -EINVAL;
> +		sbi->bggc_block_io = t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
> @@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>   #endif
>   F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>   F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
> +F2FS_SBI_GENERAL_RW_ATTR(bggc_block_io);
>   
>   /* STAT_INFO ATTR */
>   #ifdef CONFIG_F2FS_STAT_FS
> @@ -1303,6 +1311,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(discard_idle_interval),
>   	ATTR_LIST(gc_idle_interval),
>   	ATTR_LIST(umount_discard_timeout),
> +	ATTR_LIST(bggc_block_io),
>   #ifdef CONFIG_F2FS_IOSTAT
>   	ATTR_LIST(iostat_enable),
>   	ATTR_LIST(iostat_period_ms),


