Return-Path: <linux-kernel+bounces-748367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B0EB14045
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F737A60FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5C22727F6;
	Mon, 28 Jul 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7+jYF8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B501A254E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720078; cv=none; b=Rbf+unb077z+d9ycT+JRJSU9HcoccfJjFpGJe9HE9sPOme7cHkhhOBeGnTRioX0F2hXl/ytyWS2UlS6g00XtnhU9pGYJkLpkPTkwmdEMPnk+aDMPN0cAPNVTLx5qftCthR7lr/jnffi5F/kzWgAfAqGgexqSn0Toz7hjiXdj+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720078; c=relaxed/simple;
	bh=jaYdpvSZph5GN/uLRWaaBmC73dJtiUOC1QnK3SoCOv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZwNoV8e2Q9GYVtC8LVjw9haC6W3saqVew3Ht7s1YC1tyKQ8vyZcxFvSBrGt2HBW3uiheF0fnjURKztiJYkDl+uxLeNqfaTSNJ9KHSmJTL1CFSGaubKKi8lFyR2HlMg6zWAd1CAxoHwacVBKI3By3AK6/wSgGW9a/8v58isEQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7+jYF8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C00C4CEE7;
	Mon, 28 Jul 2025 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720077;
	bh=jaYdpvSZph5GN/uLRWaaBmC73dJtiUOC1QnK3SoCOv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7+jYF8JA+4m49qo7TqKaDtoHNnU4AlELj4bsUwGS+XqBJJ5wJrOnV8/O1kN0OHjF
	 MtMA75KOzWO9yTwDH/UxGt2sRDVX3r70KquzUAPbbhisgsSjP8igCCZnSSLGssw66x
	 OK7TxGgpqIK18sJilR5KOLjPhQ1RoYInTAEfBUd6CTwAp3GnlSPocRIujOett/n1I3
	 HuWu7SqNC48Jl++MdUYjqYiBE4251w2N58HIhvFbHG7jQr41e3SMzWA/KsqZly8fQx
	 ehwNAfGyO555z/zPpOGdqtz2aBdnukq4fIU1ItCNC9wuKfcdSlZq4L3sU93oftzmTQ
	 HIfDynnLN42/w==
Date: Mon, 28 Jul 2025 16:27:55 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs:Add adjustable write endpoints for multiple devices
Message-ID: <aIelC5HYSNEfV3Fx@google.com>
References: <20250723084955.547901-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723084955.547901-1-liaoyuanhong@vivo.com>

I think this is a simple hack, so NAK.

It seems the ask is to support storage tiering, and we need to design a better
approach. Something like allocating a section per defined device priority.

On 07/23, Liao Yuanhong wrote:
> During the development process, we encounter the following two issues:
> 
> 1.In a multi-device scenario, it's likely that two devices exhibit
> inconsistent performance, causing fluctuations in performance and making
> usage and testing inconvenient. Under normal circumstances, we hope to
> prioritize the use of the device with better performance and consider the
> device with poorer performance when space is insufficient. Using reuse
> mode can solve some of the issues, but tests reveal that the fragmentation
> degree in reuse mode is significantly higher than in default mode, which
> poses performance risks.
> 
> 2.We need to examine the differences in data placement for different sizes
> of storage devices under specific write patterns. Currently, this
> comparison can only be made by switching storage devices.
> 
> To address the above issues, I am considering adding a last_secno node. By
> adjusting this node, we can change the end of the addressing in
> get_new_segment so that it readdresses from 0 once the set value is
> reached. The default value of the node is the maximum number of sections
> for the current storage device, so making no modifications will not affect
> the current logic. If the space before the set value is already filled with
> valid data, it will normally write into the free area after the set value.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
>  fs/f2fs/f2fs.h                          | 1 +
>  fs/f2fs/segment.c                       | 4 ++--
>  fs/f2fs/super.c                         | 1 +
>  fs/f2fs/sysfs.c                         | 9 +++++++++
>  5 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index c2a233f2a085..e5ad8dc70cb6 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -870,3 +870,11 @@ Description:	This threshold is used to control triggering garbage collection whi
>  		reserved section before preallocating on pinned file.
>  		By default, the value is ovp_sections, especially, for zoned ufs, the
>  		value is 1.
> +
> +What:		/sys/fs/f2fs/<disk>/last_secno
> +Date:		July 2025
> +Contact:	"Yuanhong Liao" <liaoyuanhong@vivo.com>
> +Description:	This node is used to adjust the addressing end of f2fs when writing.
> +		The default value is the maximum number of sections in the storage. If the
> +		frontend space is full after adjusting the address, it will still address to
> +		the back of the address until reaching the end of the memory.
> \ No newline at end of file
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6dcd7e6f47c..7d93d8671033 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1802,6 +1802,7 @@ struct f2fs_sb_info {
>  	spinlock_t dev_lock;			/* protect dirty_device */
>  	bool aligned_blksize;			/* all devices has the same logical blksize */
>  	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
> +	unsigned int last_secno;		/* for adjust the end of target device */
>  
>  	/* For write statistics */
>  	u64 sectors_written_start;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index cc82d42ef14c..192619bb2034 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2811,7 +2811,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> -	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
> +	if (secno >= sbi->last_secno && f2fs_sb_has_blkzoned(sbi)) {
>  		/* Write only to sequential zones */
>  		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
>  			hint = GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno);
> @@ -2827,7 +2827,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  	}
>  #endif
>  
> -	if (secno >= MAIN_SECS(sbi)) {
> +	if (secno >= sbi->last_secno) {
>  		secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
>  		if (secno >= MAIN_SECS(sbi)) {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 30c038413040..5b7de0734da7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3859,6 +3859,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  	segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>  	secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>  	total_sections = le32_to_cpu(raw_super->section_count);
> +	sbi->last_secno = total_sections;
>  
>  	/* blocks_per_seg should be 512, given the above check */
>  	blocks_per_seg = BIT(le32_to_cpu(raw_super->log_blocks_per_seg));
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index bdef926b3377..a4ab5c38e883 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -649,6 +649,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  
> +	if (!strcmp(a->attr.name, "last_secno")) {
> +		if (t < 0 || t > MAIN_SECS(sbi))
> +			return -EINVAL;
> +		sbi->last_secno = t;
> +		return count;
> +	}
> +
>  #ifdef CONFIG_F2FS_IOSTAT
>  	if (!strcmp(a->attr.name, "iostat_enable")) {
>  		sbi->iostat_enable = !!t;
> @@ -1122,6 +1129,7 @@ F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(dir_level);
> +F2FS_SBI_GENERAL_RW_ATTR(last_secno);
>  #ifdef CONFIG_F2FS_IOSTAT
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>  F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
> @@ -1285,6 +1293,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(discard_idle_interval),
>  	ATTR_LIST(gc_idle_interval),
>  	ATTR_LIST(umount_discard_timeout),
> +	ATTR_LIST(last_secno),
>  #ifdef CONFIG_F2FS_IOSTAT
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(iostat_period_ms),
> -- 
> 2.34.1

