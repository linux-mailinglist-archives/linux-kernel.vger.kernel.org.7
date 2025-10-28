Return-Path: <linux-kernel+bounces-872926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9EC12A37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34B984E8676
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18A1D2F42;
	Tue, 28 Oct 2025 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ+L5Wqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CA1D5151
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617552; cv=none; b=d5W+Pdxk4oSwPXIzH34PRzy6DfVyc8tYj5JowaNaoECNzclIqp8KuUtU4prXBPvlw+pMYgytdyOCS0iqkyaRI498MK70r1eU5GK/0NSEl5jhJ4kB+6BbTtwKyDF8w9QlfbbSXxDxONiMno8O9tje71RdKl+EJ9t+es9ocxqg1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617552; c=relaxed/simple;
	bh=2afyRXJVO8CafZ/pmLoLxmT7KFA+ArUqCZBkGqjuNKw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVYa58Nh3RXPAjO+qOjwGrMPtESp4zL+REUxBjOqBclmogyfqw3h9l7BoxLp8qF/ifoZ+W3w98HcDrTMgW18/k/II+jcotpn3t3sIN/i4SXWviullgq0WYS6b72LIEBMxdtf3qk4S+HbPUf9ynsrFcoY7lpsqKCU9SbFaGPuvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ+L5Wqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE4FC4CEFB;
	Tue, 28 Oct 2025 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761617551;
	bh=2afyRXJVO8CafZ/pmLoLxmT7KFA+ArUqCZBkGqjuNKw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YZ+L5Wqd32Yh7OazP+DOD3be447r2LCKKBWt9OKzG3lAQK1Te4Fxm3V1e+mIeb5uM
	 3VGKHcbASqD3SuH3Tdn106aSJjegEAMmuXZ5wkAyx1+uEltIBBzJP4+SAps3uLNf8q
	 hALgUEjRsqB3yjUcT0+WjWhINlIcYulHS7s0gwgXw25CzvGx1rqW0kentDDgP+AaKZ
	 /ryDG4mspInGv/VxzbumqFzYQiOC02pKuZJ9WbF0jUJ3QS19g/t5zNwpOSIFdR4hUr
	 sj6sZexwiBe+C/HKNxotcPUhpsZmeA0gJ2+C3Yr0HNzkAWA7CKl6Ut6q6M8SeRwoxR
	 L//icpbJFJHJg==
Message-ID: <6e0b2709-a02a-4c25-8d44-373dd5521b8b@kernel.org>
Date: Tue, 28 Oct 2025 10:12:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs-tools: revert summary entry count from
 2048 to 512 in 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251027193332.4016328-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251027193332.4016328-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 03:33, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The recent increase in the number of Segment Summary Area (SSA) entries
> from 512 to 2048 was an unintentional change in logic of 16kb block
> support. This commit corrects the issue.
> 
> To better utilize the space available from the erroneous 2048-entry
> calculation, we are implementing a solution to share the currently
> unused SSA space with neighboring segments. This enhances overall
> SSA utilization without impacting the established 8MB segment size.
> 
> Fixes: 50fd00b168d7 ("f2fs-tools: Support different block sizes")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v3: add a feature to prevent from mounting deprecated format
> v2: detect legacy layout and prevent mount.
>     fix ssa block calculation bug in resize tool.
> ---
>  fsck/f2fs.h             | 18 +++++++++++-
>  fsck/fsck.c             | 16 ++++-------
>  fsck/fsck.h             |  5 ++++
>  fsck/inject.c           |  4 +--
>  fsck/mount.c            | 60 ++++++++++++++++++++++-----------------
>  fsck/resize.c           | 62 +++++++++++++++++++++++------------------
>  include/f2fs_fs.h       | 17 +++++++----
>  lib/libf2fs_io.c        | 12 ++++++++
>  mkfs/f2fs_format.c      |  6 +++-
>  mkfs/f2fs_format_main.c |  2 ++
>  10 files changed, 127 insertions(+), 75 deletions(-)
> 
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index 187e73c..538c99e 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -441,8 +441,10 @@ static inline block_t __end_block_addr(struct f2fs_sb_info *sbi)
>  	(SM_I(sbi) ? SM_I(sbi)->seg0_blkaddr :				\
>  		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment0_blkaddr))
>  
> +#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
>  #define GET_SUM_BLKADDR(sbi, segno)					\
> -	((sbi->sm_info->ssa_blkaddr) + segno)
> +	((SM_I(sbi)->ssa_blkaddr) + segno / SUMS_PER_BLOCK)
> +#define GET_SUM_BLKOFF(segno)	(segno % SUMS_PER_BLOCK)
>  
>  #define GET_SEGOFF_FROM_SEG0(sbi, blk_addr)				\
>  	((blk_addr) - SM_I(sbi)->seg0_blkaddr)
> @@ -492,6 +494,20 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>  		- (base + 1) + type;
>  }
>  
> +static inline int write_sum_block(struct f2fs_sb_info *sbi,
> +		void *buf, unsigned int segno, enum rw_hint whint)
> +{
> +	return dev_write_4k_block(buf, GET_SUM_BLKADDR(sbi, segno),
> +			GET_SUM_BLKOFF(segno), whint);
> +}
> +
> +static inline int read_sum_block(struct f2fs_sb_info *sbi,
> +		void *buf, unsigned int segno)
> +{
> +	return dev_read_4k_block(buf, GET_SUM_BLKADDR(sbi, segno),
> +			GET_SUM_BLKOFF(segno));
> +}
> +
>  /* for the list of fsync inodes, used only during recovery */
>  struct fsync_inode_entry {
>  	struct list_head list;	/* list head */
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 4c36dc1..d0766a9 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -228,11 +228,9 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		}
>  	}
>  	if (need_fix && f2fs_dev_is_writable()) {
> -		u64 ssa_blk;
>  		int ret2;
>  
> -		ssa_blk = GET_SUM_BLKADDR(sbi, segno);
> -		ret2 = dev_write_block(sum_blk, ssa_blk, WRITE_LIFE_NONE);
> +		ret2 = write_sum_block(sbi, sum_blk, segno, WRITE_LIFE_NONE);
>  		ASSERT(ret2 >= 0);
>  	}
>  out:
> @@ -367,11 +365,9 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
>  		}
>  	}
>  	if (need_fix && f2fs_dev_is_writable()) {
> -		u64 ssa_blk;
>  		int ret2;
>  
> -		ssa_blk = GET_SUM_BLKADDR(sbi, segno);
> -		ret2 = dev_write_block(sum_blk, ssa_blk, WRITE_LIFE_NONE);
> +		ret2 = write_sum_block(sbi, sum_blk, segno, WRITE_LIFE_NONE);
>  		ASSERT(ret2 >= 0);
>  	}
>  out:
> @@ -3879,14 +3875,12 @@ int fsck_verify(struct f2fs_sb_info *sbi)
>  			rewrite_sit_area_bitmap(sbi);
>  			if (c.zoned_model == F2FS_ZONED_HM) {
>  				struct curseg_info *curseg;
> -				u64 ssa_blk;
>  
>  				for (i = 0; i < NO_CHECK_TYPE; i++) {
>  					curseg = CURSEG_I(sbi, i);
> -					ssa_blk = GET_SUM_BLKADDR(sbi,
> -							curseg->segno);
> -					ret = dev_write_block(curseg->sum_blk,
> -							ssa_blk,
> +					ret = write_sum_block(sbi,
> +							curseg->sum_blk,
> +							curseg->segno,
>  							WRITE_LIFE_NONE);
>  					ASSERT(ret >= 0);
>  				}
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 40cb6d9..7e96b39 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -292,6 +292,11 @@ extern bool is_sit_bitmap_set(struct f2fs_sb_info *sbi, u32 blk_addr);
>  int f2fs_defragment(struct f2fs_sb_info *, u64, u64, u64, int);
>  
>  /* resize.c */
> +#define GET_SUM_NEW_BLKADDR(new_sb, segno)	\
> +	(get_newsb(ssa_blkaddr) +		\
> +	 (segno >> (get_newsb(log_blocksize) - DEFAULT_BLKSIZE_BITS)))
> +#define GET_SUM_NEW_BLKOFF(new_sb, segno)	\
> +	(segno % (1 << (get_newsb(log_blocksize) - DEFAULT_BLKSIZE_BITS)))
>  int f2fs_resize(struct f2fs_sb_info *);
>  
>  /* sload.c */
> diff --git a/fsck/inject.c b/fsck/inject.c
> index bd6ab84..fe5c293 100644
> --- a/fsck/inject.c
> +++ b/fsck/inject.c
> @@ -689,7 +689,6 @@ static int inject_ssa(struct f2fs_sb_info *sbi, struct inject_option *opt)
>  	struct summary_footer *footer;
>  	struct f2fs_summary *sum;
>  	u32 segno, offset;
> -	block_t ssa_blkaddr;
>  	int type;
>  	int ret;
>  
> @@ -754,8 +753,7 @@ static int inject_ssa(struct f2fs_sb_info *sbi, struct inject_option *opt)
>  
>  	print_sum_footer_info(footer);
>  
> -	ssa_blkaddr = GET_SUM_BLKADDR(sbi, segno);
> -	ret = dev_write_block(sum_blk, ssa_blkaddr, WRITE_LIFE_NONE);
> +	ret = write_sum_block(sbi, sum_blk, segno, WRITE_LIFE_NONE);
>  	ASSERT(ret >= 0);
>  
>  out:
> diff --git a/fsck/mount.c b/fsck/mount.c
> index a1c4cbb..40159ce 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1170,6 +1170,20 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, enum SB_ADDR sb_addr)
>  		return -1;
>  	}
>  
> +	/*
> +	 * Check for legacy summary layout on 16KB+ block devices.
> +	 * Modern f2fs-tools packs multiple 4KB summary areas into one block,
> +	 * whereas legacy versions used one block per summary, leading
> +	 * to a much larger SSA.
> +	 */
> +	if (blocksize != F2FS_SUM_BLKSIZE  &&
> +			!(get_sb(feature) & F2FS_FEATURE_PACKED_SSA)) {
> +		MSG(0, "Error: Device formatted with a legacy version. "
> +			"Please reformat with a tool supporting the packed ssa "
> +			"feature for block sizes larger than 4kb.\n");
> +		return -1;
> +	}
> +
>  	if (sanity_check_area_boundary(sb, sb_addr))
>  		return -1;
>  	return 0;
> @@ -2144,6 +2158,7 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
>  	struct curseg_info *curseg;
>  	unsigned int segno = 0;
>  	block_t blk_addr = 0;
> +	__u32 blk_offset = 0;
>  	int ret;
>  
>  	if (IS_DATASEG(type)) {
> @@ -2154,24 +2169,26 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
>  			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
>  	} else {
>  		segno = get_cp(cur_node_segno[type - CURSEG_HOT_NODE]);
> -		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
> +		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG)) {
>  			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
>  							type - CURSEG_HOT_NODE);
> -		else
> +		} else {
>  			blk_addr = GET_SUM_BLKADDR(sbi, segno);
> +			blk_offset = GET_SUM_BLKOFF(segno);
> +		}
>  	}
>  
> -	sum_blk = malloc(F2FS_BLKSIZE);
> +	sum_blk = malloc(F2FS_SUM_BLKSIZE);
>  	ASSERT(sum_blk);
>  
> -	ret = dev_read_block(sum_blk, blk_addr);
> +	ret = dev_read_4k_block(sum_blk, blk_addr, blk_offset);
>  	ASSERT(ret >= 0);
>  
>  	if (IS_NODESEG(type) && !is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
>  		restore_node_summary(sbi, segno, sum_blk);
>  
>  	curseg = CURSEG_I(sbi, type);
> -	memcpy(curseg->sum_blk, sum_blk, F2FS_BLKSIZE);
> +	memcpy(curseg->sum_blk, sum_blk, F2FS_SUM_BLKSIZE);
>  	reset_curseg(sbi, type);
>  	free(sum_blk);
>  }
> @@ -2199,8 +2216,7 @@ void update_sum_entry(struct f2fs_sb_info *sbi, block_t blk_addr,
>  							SUM_TYPE_DATA;
>  
>  	/* write SSA all the time */
> -	ret = dev_write_block(sum_blk, GET_SUM_BLKADDR(sbi, segno),
> -			      WRITE_LIFE_NONE);
> +	ret = write_sum_block(sbi, sum_blk, segno, WRITE_LIFE_NONE);
>  	ASSERT(ret >= 0);
>  
>  	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
> @@ -2399,11 +2415,9 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
>  	struct f2fs_summary_block *sum_blk;
>  	struct curseg_info *curseg;
>  	int type, ret;
> -	u64 ssa_blk;
>  
>  	*ret_type= SEG_TYPE_MAX;
>  
> -	ssa_blk = GET_SUM_BLKADDR(sbi, segno);
>  	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
>  		curseg = CURSEG_I(sbi, CURSEG_HOT_NODE + type);
>  		if (segno == curseg->segno) {
> @@ -2434,10 +2448,10 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
>  		}
>  	}
>  
> -	sum_blk = calloc(F2FS_BLKSIZE, 1);
> +	sum_blk = calloc(F2FS_SUM_BLKSIZE, 1);
>  	ASSERT(sum_blk);
>  
> -	ret = dev_read_block(sum_blk, ssa_blk);
> +	ret = read_sum_block(sbi, sum_blk, segno);
>  	ASSERT(ret >= 0);
>  
>  	if (IS_SUM_NODE_SEG(sum_blk))
> @@ -3054,7 +3068,6 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
>  		struct curseg_info *curseg = CURSEG_I(sbi, want_type);
>  		unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
>  		char buf[F2FS_BLKSIZE];

		char buf[F2FS_SUM_BLKSIZE];

> -		u64 ssa_blk;
>  		int ret;
>  
>  		*to = NEXT_FREE_BLKADDR(sbi, curseg);
> @@ -3072,17 +3085,15 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
>  				segno = GET_SEGNO(sbi, new_blkaddr);
>  			}
>  
> -			ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
> -			ret = dev_write_block(curseg->sum_blk, ssa_blk,
> -					      WRITE_LIFE_NONE);
> +			ret = write_sum_block(sbi, curseg->sum_blk,
> +					curseg->segno, WRITE_LIFE_NONE);
>  			ASSERT(ret >= 0);
>  
>  			curseg->segno = segno;
>  			curseg->next_blkoff = 0;
>  			curseg->alloc_type = LFS;
>  
> -			ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
> -			ret = dev_read_block(&buf, ssa_blk);
> +			ret = read_sum_block(sbi, &buf, curseg->segno);
>  			ASSERT(ret >= 0);
>  
>  			memcpy(curseg->sum_blk, &buf, SUM_ENTRIES_SIZE);
> @@ -3160,7 +3171,7 @@ void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
>  	struct curseg_info *curseg = CURSEG_I(sbi, i);
>  	char buf[F2FS_BLKSIZE];

	char buf[F2FS_SUM_BLKSIZE];

>  	u32 old_segno;
> -	u64 ssa_blk, to;
> +	u64 to;
>  	int ret;
>  
>  	if ((get_sb(feature) & F2FS_FEATURE_RO)) {
> @@ -3178,8 +3189,8 @@ void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
>  	}
>  
>  	/* update original SSA too */
> -	ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
> -	ret = dev_write_block(curseg->sum_blk, ssa_blk, WRITE_LIFE_NONE);
> +	ret = write_sum_block(sbi, curseg->sum_blk, curseg->segno,
> +			WRITE_LIFE_NONE);
>  	ASSERT(ret >= 0);
>  bypass_ssa:
>  	to = from;
> @@ -3193,8 +3204,7 @@ bypass_ssa:
>  	curseg->alloc_type = c.zoned_model == F2FS_ZONED_HM ? LFS : SSR;
>  
>  	/* update new segno */
> -	ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
> -	ret = dev_read_block(buf, ssa_blk);
> +	ret = read_sum_block(sbi, buf, curseg->segno);
>  	ASSERT(ret >= 0);
>  
>  	memcpy(curseg->sum_blk, buf, SUM_ENTRIES_SIZE);
> @@ -3440,7 +3450,6 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	/* update summary blocks having nullified journal entries */
>  	for (i = 0; i < NO_CHECK_TYPE; i++) {
>  		struct curseg_info *curseg = CURSEG_I(sbi, i);
> -		u64 ssa_blk;
>  
>  		if (!(flags & CP_UMOUNT_FLAG) && IS_NODESEG(i))
>  			continue;
> @@ -3451,9 +3460,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  
>  		if (!(get_sb(feature) & F2FS_FEATURE_RO)) {
>  			/* update original SSA too */
> -			ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
> -			ret = dev_write_block(curseg->sum_blk, ssa_blk,
> -					      WRITE_LIFE_NONE);
> +			ret = write_sum_block(sbi, curseg->sum_blk,
> +					curseg->segno, WRITE_LIFE_NONE);
>  			ASSERT(ret >= 0);
>  		}
>  	}
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 58914ec..f71290a 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -115,7 +115,8 @@ static int get_new_sb(struct f2fs_super_block *sb)
>  			get_sb(segment_count_sit) +
>  			get_sb(segment_count_nat))) * blks_per_seg;
>  
> -	blocks_for_ssa = total_valid_blks_available / blks_per_seg + 1;
> +	blocks_for_ssa = round_up(total_valid_blks_available / blks_per_seg,
> +			SUMS_PER_BLOCK);
>  
>  	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
>  
> @@ -209,23 +210,24 @@ static void migrate_main(struct f2fs_sb_info *sbi, unsigned int offset)
>  				START_BLOCK(sbi, 0) + offset);
>  }
>  
> -static void move_ssa(struct f2fs_sb_info *sbi, unsigned int segno,
> -					block_t new_sum_blk_addr)
> +static void move_ssa(struct f2fs_sb_info *sbi, struct f2fs_super_block *new_sb,
> +		unsigned int old_segno, unsigned int new_segno)
>  {
>  	struct f2fs_summary_block *sum_blk;
>  	int type;
>  
> -	sum_blk = get_sum_block(sbi, segno, &type);
> +	sum_blk = get_sum_block(sbi, old_segno, &type);
>  	if (type < SEG_TYPE_MAX) {
>  		int ret;
> +		u64 new_blkaddr = GET_SUM_NEW_BLKADDR(new_sb, new_segno);
> +		u32 new_blkoff = GET_SUM_NEW_BLKOFF(new_sb, new_segno);
>  
> -		ret = dev_write_block(sum_blk, new_sum_blk_addr,
> -				      WRITE_LIFE_NONE);
> +		ret = dev_write_4k_block(sum_blk, new_blkaddr, new_blkoff,
> +				WRITE_LIFE_NONE);
>  		ASSERT(ret >= 0);
>  		DBG(1, "Write summary block: (%d) segno=%x/%x --> (%d) %x\n",
> -				type, segno, GET_SUM_BLKADDR(sbi, segno),
> -				IS_SUM_NODE_SEG(sum_blk),
> -				new_sum_blk_addr);
> +			type, old_segno, GET_SUM_BLKADDR(sbi, old_segno),
> +			IS_SUM_NODE_SEG(sum_blk), (unsigned int)new_blkaddr);
>  	}
>  	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
>  			type == SEG_TYPE_MAX) {
> @@ -240,36 +242,42 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
>  	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
> -	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
> -	block_t expand_sum_blkaddr = new_sum_blkaddr +
> -					MAIN_SEGS(sbi) - offset;
> -	block_t blkaddr;
> +	unsigned int expand_segno = MAIN_SEGS(sbi) - offset;
> +	unsigned int new_seg_total = get_newsb(segment_count);
> +	int new_segno;
>  	int ret;
> -	void *zero_block = calloc(F2FS_BLKSIZE, 1);
> +	void *zero_block = calloc(F2FS_SUM_BLKSIZE, 1);
>  	ASSERT(zero_block);
>  
> -	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
> -		blkaddr = new_sum_blkaddr;
> -		while (blkaddr < end_sum_blkaddr) {
> -			if (blkaddr < expand_sum_blkaddr) {
> -				move_ssa(sbi, offset++, blkaddr++);
> +	if (offset && new_sum_blkaddr <= (old_sum_blkaddr +
> +				offset / SUMS_PER_BLOCK)) {
> +		new_segno = 0;
> +		while (new_segno < new_seg_total) {
> +			if (new_segno < expand_segno) {
> +				move_ssa(sbi, new_sb, offset++, new_segno);
>  			} else {
> -				ret = dev_write_block(zero_block, blkaddr++,
> -						      WRITE_LIFE_NONE);
> +				ret = dev_write_4k_block(zero_block,
> +					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
> +					GET_SUM_NEW_BLKOFF(new_sb, new_segno),
> +					WRITE_LIFE_NONE);
>  				ASSERT(ret >=0);
>  			}
> +			new_segno++;
>  		}
>  	} else {
> -		blkaddr = end_sum_blkaddr - 1;
> +		new_segno = new_seg_total - 1;
>  		offset = MAIN_SEGS(sbi) - 1;
> -		while (blkaddr >= new_sum_blkaddr) {
> -			if (blkaddr >= expand_sum_blkaddr) {
> -				ret = dev_write_block(zero_block, blkaddr--,
> -						      WRITE_LIFE_NONE);
> +		while (new_segno >= 0) {
> +			if (new_segno >= expand_segno) {
> +				ret = dev_write_4k_block(zero_block,
> +					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
> +					GET_SUM_NEW_BLKOFF(new_sb, new_segno),
> +					WRITE_LIFE_NONE);
>  				ASSERT(ret >=0);
>  			} else {
> -				move_ssa(sbi, offset--, blkaddr--);
> +				move_ssa(sbi, new_sb, offset--, new_segno);
>  			}
> +			new_segno--;
>  		}
>  	}
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index bd75dbb..e1427f7 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -655,6 +655,7 @@ enum {
>  #define F2FS_MIN_BLKSIZE		4096
>  #define F2FS_MAX_BLKSIZE		16384
>  #define F2FS_BLKSIZE			c.blksize	/* support configurable block size */
> +#define F2FS_SUM_BLKSIZE		4096
>  #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
>  #define F2FS_EXTENSION_LEN		8	/* max size of extension */
>  #define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
> @@ -715,6 +716,7 @@ enum {
>  #define F2FS_FEATURE_COMPRESSION	0x2000
>  #define F2FS_FEATURE_RO			0x4000
>  #define F2FS_FEATURE_DEVICE_ALIAS	0x8000
> +#define F2FS_FEATURE_PACKED_SSA		0x10000
>  
>  #define MAX_NR_FEATURE			32
>  
> @@ -1218,7 +1220,7 @@ struct f2fs_sit_block {
>   * from node's page's beginning to get a data block address.
>   * ex) data_blkaddr = (block_t)(nodepage_start_address + ofs_in_node)
>   */
> -#define ENTRIES_IN_SUM		(F2FS_BLKSIZE / 8)
> +#define ENTRIES_IN_SUM		(F2FS_SUM_BLKSIZE / 8)
>  #define	SUMMARY_SIZE		(7)	/* sizeof(struct summary) */
>  #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
>  #define SUM_ENTRIES_SIZE	(SUMMARY_SIZE * ENTRIES_IN_SUM)
> @@ -1248,7 +1250,7 @@ struct summary_footer {
>  
>  static_assert(sizeof(struct summary_footer) == 5, "");
>  
> -#define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> +#define SUM_JOURNAL_SIZE	(F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
>  				SUM_ENTRIES_SIZE)
>  #define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
>  				sizeof(struct nat_journal_entry))
> @@ -1347,7 +1349,7 @@ struct f2fs_summary_block {
>  };
>  #define F2FS_SUMMARY_BLOCK_JOURNAL(blk) ((struct f2fs_journal *)(&(blk)->entries[ENTRIES_IN_SUM]))
>  #define F2FS_SUMMARY_BLOCK_FOOTER(blk) ((struct summary_footer *)&((char *)\
> -					(&(blk)->entries[0]))[F2FS_BLKSIZE - SUM_FOOTER_SIZE])
> +		(&(blk)->entries[0]))[F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE])
>  
>  /*
>   * For directory operations
> @@ -1709,6 +1711,8 @@ extern int dev_fill_block(void *, __u64, enum rw_hint);
>  
>  extern int dev_read_block(void *, __u64);
>  extern int dev_reada_block(__u64);
> +extern int dev_write_4k_block(void *, __u64, __u32, enum rw_hint);
> +extern int dev_read_4k_block(void *, __u64, __u32);
>  
>  extern int dev_read_version(void *, __u64, size_t);
>  extern void get_kernel_version(__u8 *);
> @@ -2020,6 +2024,7 @@ struct feature feature_table[] = {					\
>  	{ "compression",		F2FS_FEATURE_COMPRESSION,	1}, \
>  	{ "ro",				F2FS_FEATURE_RO,		1}, \
>  	{ "device_alias",		F2FS_FEATURE_DEVICE_ALIAS,	0}, \
> +	{ "packed_ssa",			F2FS_FEATURE_PACKED_SSA,	0}, \
>  	{ NULL,				0x0,				0}, \
>  };
>  
> @@ -2159,18 +2164,18 @@ static inline void check_block_struct_sizes(void)
>  	assert(sizeof(struct f2fs_summary) * ENTRIES_IN_SUM
>  			+ offsetof(struct f2fs_journal, nat_j)
>  			+ NAT_JOURNAL_ENTRIES * sizeof(struct nat_journal_entry)
> -			+ NAT_JOURNAL_RESERVED + sizeof(struct summary_footer) == F2FS_BLKSIZE);
> +			+ NAT_JOURNAL_RESERVED + sizeof(struct summary_footer) == F2FS_SUM_BLKSIZE);
>  
>  	/* Check SIT Journal Block Size */
>  	assert(sizeof(struct f2fs_summary) * ENTRIES_IN_SUM
>  			+ offsetof(struct f2fs_journal, sit_j)
>  			+ SIT_JOURNAL_ENTRIES * sizeof(struct sit_journal_entry)
> -			+ SIT_JOURNAL_RESERVED + sizeof(struct summary_footer) == F2FS_BLKSIZE);
> +			+ SIT_JOURNAL_RESERVED + sizeof(struct summary_footer) == F2FS_SUM_BLKSIZE);
>  
>  	/* Check Info Journal Block Size */
>  	assert(sizeof(struct f2fs_summary) * ENTRIES_IN_SUM + sizeof(__le64)
>  			+ offsetof(struct f2fs_journal, info)
> -			+ EXTRA_INFO_RESERVED + sizeof(struct summary_footer) == F2FS_BLKSIZE);
> +			+ EXTRA_INFO_RESERVED + sizeof(struct summary_footer) == F2FS_SUM_BLKSIZE);
>  
>  	/* Check Dentry Block Size */
>  	assert(sizeof(__u8) * (SIZE_OF_DENTRY_BITMAP + SIZE_OF_RESERVED)
> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> index 2030440..919318e 100644
> --- a/lib/libf2fs_io.c
> +++ b/lib/libf2fs_io.c
> @@ -734,6 +734,18 @@ int dev_reada_block(__u64 blk_addr)
>  	return dev_readahead(blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
>  }
>  
> +int dev_write_4k_block(void *buf, __u64 blk_addr, __u32 offset, enum rw_hint whint)
> +{
> +	return dev_write(buf, (blk_addr << F2FS_BLKSIZE_BITS) + offset * 4096,
> +			4096, whint);
> +}
> +
> +int dev_read_4k_block(void *buf, __u64 blk_addr, __u32 offset)
> +{
> +	return dev_read(buf, (blk_addr << F2FS_BLKSIZE_BITS) + offset * 4096,
> +			4096);
> +}
> +
>  int f2fs_fsync_device(void)
>  {
>  #ifdef HAVE_FSYNC
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 6deb671..6efad45 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -500,8 +500,12 @@ static int f2fs_prepare_super_block(void)
>  	if (c.feature & F2FS_FEATURE_RO) {
>  		blocks_for_ssa = 0;
>  	} else {
> +		unsigned int ssa_per_block;
> +
>  		ASSERT((total_valid_blks_available % c.blks_per_seg) == 0);
> -		blocks_for_ssa = total_valid_blks_available / c.blks_per_seg;
> +		ssa_per_block = c.blksize / F2FS_SUM_BLKSIZE;
> +		blocks_for_ssa = round_up(total_valid_blks_available /
> +				c.blks_per_seg,	ssa_per_block);
>  	}
>  
>  	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 8f8e975..5e509c8 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -209,6 +209,8 @@ static void f2fs_parse_options(int argc, char *argv[])
>  				MSG(0, "Error: Block size must be power of 2");
>  				mkfs_usage();
>  			}
> +			if (c.blksize != F2FS_SUM_BLKSIZE)
> +				c.feature |= F2FS_FEATURE_PACKED_SSA;

What do you think of relocating this into add_default_options()?

Thanks,

>  			break;
>  		case 'c':
>  			dev_num = c.ndevs;


