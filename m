Return-Path: <linux-kernel+bounces-789133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B44B39183
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2BA36404A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52024678E;
	Thu, 28 Aug 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx4Yf2ay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902F2417FB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347052; cv=none; b=a3JeSI45EonM+94bAaSYzaYONDEjfVzPiBfBAO/8+mqyJ6eKmnQ76u1dvedEBOHfj2OW8PHJhSlQDWf8nmrtbBWG5bzNHFT4mRMpoufV7QNQDJgUkEi8fLkw2245Il3I/+nNKkFzHK660luGISN+rHNjU3y852c8WqUnrtqk8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347052; c=relaxed/simple;
	bh=I/jl3JBbmddIpRaZhOPv+LLmwGKvtpC48Rl8iE1wL5I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nWuzOWy6IQYsXD/xtQ8B2LaI5+4FIbm3yNMi//zoPemUFqRe82AKLtX8Z1ICVTmQcX+hM9Oce5OaYMXpN0f/FboImFldI2+5uWyPx0QGgPvwxI4ThzawVKt/EaGF59oe5+KJJyGZWMrEiZUNYROpgnvB1O0dhLgneFnVuU0tN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx4Yf2ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC9C4CEEB;
	Thu, 28 Aug 2025 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756347052;
	bh=I/jl3JBbmddIpRaZhOPv+LLmwGKvtpC48Rl8iE1wL5I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Qx4Yf2ayhbLNmu1ywuXTM7R3eoyIMlMoz0RVOUG22nSBkc4xI9XudZ3ko/Ii/ufUV
	 oiqWh//nf+5nwgLWXv8GQoFRLvXLnXCHcQNvC5fJLGNf7TWsqnoM8OKW7c5KehL3N1
	 xN8WDjS09/vSRSLrDryB6ebXFeJYTnTwuvL/LmFnYwsaKZDvdCk030Nf5opCginnwo
	 bU6oS4Ifvx7EWg8VN9qPkU29MG4GUWZoX1946EYIG7YbcKJQ+2tRJBz6hXx7aIOUC7
	 mnp4ttqKXjs84+qQF4MCRFJ+Gx7xc8DfXg/fG3mg7aHGINJ/gO7mQDX1Pil0rIrwce
	 LWB2YG36va+Aw==
Message-ID: <5c955a76-8a12-4001-b89a-8e1b84b36564@kernel.org>
Date: Thu, 28 Aug 2025 10:10:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH v3] f2fs: Use allocate_section_policy to control write
 priority in multi-devices setups
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250826140539.521074-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250826140539.521074-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 22:05, Liao Yuanhong wrote:
> Introduces two new sys nodes: allocate_section_hint and
> allocate_section_policy. The allocate_section_hint identifies the boundary
> between devices, measured in sections; it defaults to the end of the device
> for single storage setups, and the end of the first device for multiple
> storage setups. The allocate_section_policy determines the write strategy,
> with a default value of 0 for normal sequential write strategy. A value of
> 1 prioritizes writes before the allocate_section_hint, while a value of 2
> prioritizes writes after it.
> 
> This strategy addresses the issue where, despite F2FS supporting multiple
> devices, SOC vendors lack multi-devices support (currently only supporting
> zoned devices). As a workaround, multiple storage devices are mapped to a
> single dm device. Both this workaround and the F2FS multi-devices solution
> may require prioritizing writing to certain devices, such as a device with
> better performance or when switching is needed due to performance
> degradation near a device's end. For scenarios with more than two devices,
> sort them at mount time to utilize this feature.
> 
> When using this feature with a single storage device, it has almost no
> impact. However, for configurations where multiple storage devices are
> mapped to the same dm device using F2FS, utilizing this feature can provide
> some optimization benefits. Therefore, I believe it should not be limited
> to just multi-devices usage.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> Changes in v3:
> 	- Refactored the implementation logic of allocate_section_policy in
> 	get_new_segment(). The current version has a more coherent and readable
> 	logic while maintaining nearly the same functionality.
> 	- Added a validity check for allocate_section_hint in get_new_segment()
> 	to prevent potential conflicts that MAIN_SECS() might cause.
> 	- Adjusted the initialization position of allocate_section_hint, now
> 	initialized in init_sb_info().
> 
> Changes in v2:
> 	- Updated the feature naming to better reflect its actual functionality.
> 	- Appended patch description to clarify whether the usage should be
> 	limited to multi-devices.
> 	- Improved the code style.
> 	- Fixed typo.
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 22 ++++++++++++++++++++++
>  fs/f2fs/f2fs.h                          |  8 ++++++++
>  fs/f2fs/gc.c                            |  5 +++++
>  fs/f2fs/segment.c                       | 15 +++++++++++++++
>  fs/f2fs/super.c                         |  4 ++++
>  fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>  6 files changed, 72 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index ee3acc8c2cb8..b590809869ca 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -911,3 +911,25 @@ Description:	Used to adjust the BG_GC priority when pending IO, with a default v
>  		bggc_io_aware = 1   skip background GC if there is pending read IO
>  		bggc_io_aware = 2   don't aware IO for background GC
>  		==================  ======================================================
> +
> +What:		/sys/fs/f2fs/<disk>/allocate_section_hint
> +Date:		August 2025
> +Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
> +Description:	Indicates the hint section between the first device and others in multi-devices
> +		setup. It defaults to the end of the first device in sections. For a single storage
> +		device, it defaults to the total number of sections. It can be manually set to match
> +		scenarios where multi-devices are mapped to the same dm device.
> +
> +What:		/sys/fs/f2fs/<disk>/allocate_section_policy
> +Date:		August 2025
> +Contact:	"Liao Yuanhong" <liaoyuanhong@vivo.com>
> +Description:	Controls write priority in multi-devices setups. A value of 0 means normal writing.
> +		A value of 1 prioritizes writing to devices before the allocate_section_hint. A value of 2
> +		prioritizes writing to devices after the allocate_section_hint. The default is 0.
> +
> +		===========================  ==========================================================
> +		value					     description
> +		allocate_section_policy = 0  Normal writing
> +		allocate_section_policy = 1  Prioritize writing to section before allocate_section_hint
> +		allocate_section_policy = 2  Prioritize writing to section after allocate_section_hint
> +		===========================  ==========================================================
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6cde72fce74e..7c6bfee81c61 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -162,6 +162,12 @@ enum bggc_io_aware_policy {
>  	AWARE_NONE,			/* don't aware IO for background GC */
>  };
>  
> +enum device_allocation_policy {
> +	ALLOCATE_FORWARD_NOHINT,
> +	ALLOCATE_FORWARD_WITHIN_HINT,
> +	ALLOCATE_FORWARD_FROM_HINT,
> +};
> +
>  /*
>   * An implementation of an rwsem that is explicitly unfair to readers. This
>   * prevents priority inversion when a low-priority reader acquires the read lock
> @@ -1856,6 +1862,8 @@ struct f2fs_sb_info {
>  	bool aligned_blksize;			/* all devices has the same logical blksize */
>  	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
>  	unsigned int bggc_io_aware;		/* For adjust the BG_GC priority when pending IO */
> +	unsigned int allocate_section_hint;	/* the boundary position between devices */
> +	unsigned int allocate_section_policy;	/* determine the section writing priority */
>  
>  	/* For write statistics */
>  	u64 sectors_written_start;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 098e9f71421e..b57b8fd64747 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2182,6 +2182,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  	SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>  	MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
>  	MAIN_SECS(sbi) += secs;
> +	if (sbi->allocate_section_hint > MAIN_SECS(sbi))
> +		sbi->allocate_section_hint = MAIN_SECS(sbi);
>  	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
>  	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
>  	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
> @@ -2189,6 +2191,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  	if (f2fs_is_multi_device(sbi)) {
>  		int last_dev = sbi->s_ndevs - 1;
>  
> +		sbi->allocate_section_hint = FDEV(0).total_segments /
> +					SEGS_PER_SEC(sbi);
> +
>  		FDEV(last_dev).total_segments =
>  				(int)FDEV(last_dev).total_segments + segs;
>  		FDEV(last_dev).end_blk =
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 04b0a3c1804d..e86b78111444 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2807,6 +2807,21 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	}
>  #endif
>  
> +	/*
> +	 * Prevent allocate_section_hint from exceeding MAIN_SECS()
> +	 * due to desynchronization.
> +	 */
> +	if (sbi->allocate_section_policy != ALLOCATE_FORWARD_NOHINT &&
> +		sbi->allocate_section_hint > MAIN_SECS(sbi))
> +		sbi->allocate_section_hint = MAIN_SECS(sbi);
> +
> +	if (sbi->allocate_section_policy == ALLOCATE_FORWARD_FROM_HINT &&
> +		hint < sbi->allocate_section_hint)
> +		hint = sbi->allocate_section_hint;
> +	else if (sbi->allocate_section_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
> +			hint >= sbi->allocate_section_hint)
> +		hint = 0;

I suspect use of sbi->allocate_section_hint and sbi->allocate_section_policy may
race w/ their update via sysfs node.

What about this?

unsigned int alloc_policy = sbi->allocate_section_hint;
unsigned int alloc_hint = sbi->allocate_section_hint;

if (alloc_policy != ALLOCATE_FORWARD_NOHINT &&
		alloc_hint > MAIN_SECS(sbi))
	alloc_hint = MAIN_SECS(sbi);

if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
...

Thanks,

> +
>  find_other_zone:
>  	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e288b7be3131..924ad2216f67 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4238,6 +4238,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->total_node_count = SEGS_TO_BLKS(sbi,
>  			((le32_to_cpu(raw_super->segment_count_nat) / 2) *
>  			NAT_ENTRY_PER_BLOCK));
> +	sbi->allocate_section_hint = le32_to_cpu(raw_super->section_count);
>  	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
>  	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
>  	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
> @@ -4721,6 +4722,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>  	sbi->aligned_blksize = true;
>  	sbi->bggc_io_aware = AWARE_ALL_IO;
> +	sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	sbi->max_open_zones = UINT_MAX;
>  	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
> @@ -4752,6 +4754,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  					SEGS_TO_BLKS(sbi,
>  					FDEV(i).total_segments) - 1 +
>  					le32_to_cpu(raw_super->segment0_blkaddr);
> +				sbi->allocate_section_hint = FDEV(i).total_segments /
> +							SEGS_PER_SEC(sbi);
>  			} else {
>  				FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
>  				FDEV(i).end_blk = FDEV(i).start_blk +
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 1ffaf9e74ce9..81b99c2a02a9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -889,6 +889,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "allocate_section_hint")) {
> +		if (t < 0 || t > MAIN_SECS(sbi))
> +			return -EINVAL;
> +		sbi->allocate_section_hint = t;
> +		return count;
> +	}
> +
> +	if (!strcmp(a->attr.name, "allocate_section_policy")) {
> +		if (t < ALLOCATE_FORWARD_NOHINT || t > ALLOCATE_FORWARD_FROM_HINT)
> +			return -EINVAL;
> +		sbi->allocate_section_policy = t;
> +		return count;
> +	}
> +
>  	*ui = (unsigned int)t;
>  
>  	return count;
> @@ -1161,6 +1175,8 @@ F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(dir_level);
> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_hint);
> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_policy);
>  #ifdef CONFIG_F2FS_IOSTAT
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
> @@ -1398,6 +1414,8 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(max_read_extent_count),
>  	ATTR_LIST(carve_out),
>  	ATTR_LIST(reserved_pin_section),
> +	ATTR_LIST(allocate_section_hint),
> +	ATTR_LIST(allocate_section_policy),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs);


