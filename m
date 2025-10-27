Return-Path: <linux-kernel+bounces-870938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA734C0C05E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B073B916F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE81F0E3E;
	Mon, 27 Oct 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnR4nuOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3A125A0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548416; cv=none; b=Z+qMtL+dvtd4czJRlG0gCaOTmUec3X3b/jBEfmelyvIHYzXoo13ZC6fXuFEo/5SW+OJ395bgoTEYkTrDmGnQ7uW9+DMuXk1rOwrF5A1VZYTVMA0pT1dz/cqnlbw0OMvn9YRMZgrmmsR8htT/1X064UwIuVDNTVH1FROhRoigbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548416; c=relaxed/simple;
	bh=JKAlq2P5PQtDiF5oM0dQwm7rlioBoiQiRjspQzQ464k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nqv33mYiYr7PwwxdPc3WjrrygxJBJgs3alsBnlD4oA3QB7I/Nv3kcuhwWbx+WhPPaH/yl2nJOjEWhcWossScDPGSpoiRVJFLS47zXIdNtA87RroQEYshpKGzeGVagcfEX2vVTROfHzeOjq6zkSjQs8UZvZksiGOXvWap5opMTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnR4nuOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3202FC4CEF1;
	Mon, 27 Oct 2025 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761548415;
	bh=JKAlq2P5PQtDiF5oM0dQwm7rlioBoiQiRjspQzQ464k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MnR4nuODgfZkBD8dC17hDR5XQPyzuurZHhziZvLsUin+0rtHu6g4bgH3JptimEweZ
	 T4lyDxyRTuVVM3S28Sv6m3wI+8mSQXlHgSW4ITE+48ese1fo7kWXe1NpbXKBiYI9co
	 KnakwhHMT1BIDyYM6pEL8f8SNVaTEvhb7nhfuKOdDYmEA3oXVP1sNf/eMVBfL4Kli1
	 1eChgvXPvWAA8ks3FOfCGAue7MHpyfqHrdayBMyqXScKhsFsa2lppHj4MOHiOfGml+
	 RXKqdaDf2bN4MWB6M20bgx/djsAU/Db9oPFTOaXwSrxRgvebclcg2nqFtDiPTIGo3Z
	 BzVcxtawfRMbA==
Message-ID: <398451e1-3cc4-4f9d-be0d-6ecf68e71f55@kernel.org>
Date: Mon, 27 Oct 2025 15:00:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: revert summary entry count from 2048
 to 512 in 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251015211133.1895311-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251015211133.1895311-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 05:11, Daeho Jeong wrote:
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
> Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: detect legacy layout and prevent mount.
> v3: error handling for a failure of f2fs_get_meta_folio().
> ---
>  fs/f2fs/gc.c            | 117 +++++++++++++++++++++++-----------------
>  fs/f2fs/recovery.c      |   2 +-
>  fs/f2fs/segment.c       |  29 ++++++----
>  fs/f2fs/segment.h       |   8 ++-
>  fs/f2fs/super.c         |  38 +++++++++++++
>  include/linux/f2fs_fs.h |   5 +-
>  6 files changed, 136 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 8abf521530ff..af2f4d28462c 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1732,7 +1732,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>  						SUM_TYPE_DATA : SUM_TYPE_NODE;
>  	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
> -	int submitted = 0;
> +	int submitted = 0, sum_blk_cnt;
>  
>  	if (__is_large_section(sbi)) {
>  		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
> @@ -1766,22 +1766,28 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
>  
> +	segno = rounddown(segno, SUMS_PER_BLOCK);
> +	sum_blk_cnt = DIV_ROUND_UP(end_segno - segno, SUMS_PER_BLOCK);
>  	/* readahead multi ssa blocks those have contiguous address */
>  	if (__is_large_section(sbi))
>  		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
> -					end_segno - segno, META_SSA, true);
> +					sum_blk_cnt, META_SSA, true);
>  
>  	/* reference all summary page */
>  	while (segno < end_segno) {
> -		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno++);
> +		struct folio *sum_folio = f2fs_get_sum_folio(sbi, segno);
> +
> +		segno += SUMS_PER_BLOCK;
>  		if (IS_ERR(sum_folio)) {
>  			int err = PTR_ERR(sum_folio);
>  
> -			end_segno = segno - 1;
> -			for (segno = start_segno; segno < end_segno; segno++) {
> +			end_segno = segno - SUMS_PER_BLOCK;
> +			segno = rounddown(start_segno, SUMS_PER_BLOCK);
> +			while (segno < end_segno) {
>  				sum_folio = filemap_get_folio(META_MAPPING(sbi),
>  						GET_SUM_BLOCK(sbi, segno));
>  				folio_put_refs(sum_folio, 2);
> +				segno += SUMS_PER_BLOCK;
>  			}
>  			return err;
>  		}
> @@ -1790,68 +1796,83 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  	blk_start_plug(&plug);
>  
> -	for (segno = start_segno; segno < end_segno; segno++) {
> -		struct f2fs_summary_block *sum;
> +	segno = start_segno;
> +	while (segno < end_segno) {
> +		unsigned int cur_segno;
>  
>  		/* find segment summary of victim */
>  		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
>  					GET_SUM_BLOCK(sbi, segno));
> +		unsigned int block_end_segno = rounddown(segno, SUMS_PER_BLOCK)
> +					+ SUMS_PER_BLOCK;
> +
> +		if (block_end_segno > end_segno)
> +			block_end_segno = end_segno;
>  
>  		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
>  			f2fs_err(sbi, "%s: segment %u is used by log",
>  							__func__, segno);
>  			f2fs_bug_on(sbi, 1);
> -			goto skip;
> +			goto next_block;
>  		}
>  
> -		if (get_valid_blocks(sbi, segno, false) == 0)
> -			goto freed;
> -		if (gc_type == BG_GC && __is_large_section(sbi) &&
> -				migrated >= sbi->migration_granularity)
> -			goto skip;
>  		if (!folio_test_uptodate(sum_folio) ||
>  		    unlikely(f2fs_cp_error(sbi)))
> -			goto skip;
> +			goto next_block;
>  
> -		sum = folio_address(sum_folio);
> -		if (type != GET_SUM_TYPE((&sum->footer))) {
> -			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SIT and SSA",
> -				 segno, type, GET_SUM_TYPE((&sum->footer)));
> -			f2fs_stop_checkpoint(sbi, false,
> -				STOP_CP_REASON_CORRUPTED_SUMMARY);
> -			goto skip;
> -		}
> +		for (cur_segno = segno; cur_segno < block_end_segno;
> +				cur_segno++) {
> +			struct f2fs_summary_block *sum;
>  
> -		/*
> -		 * this is to avoid deadlock:
> -		 * - lock_page(sum_page)         - f2fs_replace_block
> -		 *  - check_valid_map()            - down_write(sentry_lock)
> -		 *   - down_read(sentry_lock)     - change_curseg()
> -		 *                                  - lock_page(sum_page)
> -		 */
> -		if (type == SUM_TYPE_NODE)
> -			submitted += gc_node_segment(sbi, sum->entries, segno,
> -								gc_type);
> -		else
> -			submitted += gc_data_segment(sbi, sum->entries, gc_list,
> -							segno, gc_type,
> -							force_migrate);
> +			if (get_valid_blocks(sbi, cur_segno, false) == 0)
> +				goto freed;
> +			if (gc_type == BG_GC && __is_large_section(sbi) &&
> +					migrated >= sbi->migration_granularity)
> +				continue;
>  
> -		stat_inc_gc_seg_count(sbi, data_type, gc_type);
> -		sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> -		migrated++;
> +			sum = SUM_BLK_PAGE_ADDR(sum_folio, cur_segno);
> +			if (type != GET_SUM_TYPE((&sum->footer))) {
> +				f2fs_err(sbi, "Inconsistent segment (%u) type "
> +						"[%d, %d] in SSA and SIT",
> +						cur_segno, type,
> +						GET_SUM_TYPE((&sum->footer)));
> +				f2fs_stop_checkpoint(sbi, false,
> +						STOP_CP_REASON_CORRUPTED_SUMMARY);
> +				continue;
> +			}
>  
> -freed:
> -		if (gc_type == FG_GC &&
> -				get_valid_blocks(sbi, segno, false) == 0)
> -			seg_freed++;
> +			/*
> +			 * this is to avoid deadlock:
> +			 *  - lock_page(sum_page)     - f2fs_replace_block
> +			 *   - check_valid_map()        - down_write(sentry_lock)
> +			 *    - down_read(sentry_lock) - change_curseg()
> +			 *                               - lock_page(sum_page)
> +			 */
> +			if (type == SUM_TYPE_NODE)
> +				submitted += gc_node_segment(sbi, sum->entries,
> +						cur_segno, gc_type);
> +			else
> +				submitted += gc_data_segment(sbi, sum->entries,
> +						gc_list, cur_segno,
> +						gc_type, force_migrate);
>  
> -		if (__is_large_section(sbi))
> -			sbi->next_victim_seg[gc_type] =
> -				(segno + 1 < sec_end_segno) ?
> -					segno + 1 : NULL_SEGNO;
> -skip:
> +			stat_inc_gc_seg_count(sbi, data_type, gc_type);
> +			sbi->gc_reclaimed_segs[sbi->gc_mode]++;
> +			migrated++;
> +
> +freed:
> +			if (gc_type == FG_GC &&
> +					get_valid_blocks(sbi, cur_segno, false) == 0)
> +				seg_freed++;
> +
> +			if (__is_large_section(sbi))
> +				sbi->next_victim_seg[gc_type] =
> +					(cur_segno + 1 < sec_end_segno) ?
> +					cur_segno + 1 : NULL_SEGNO;
> +		}
> +next_block:
>  		folio_put_refs(sum_folio, 2);
> +		segno = block_end_segno;
>  	}
>  
>  	if (submitted)
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 215e442db72c..af72309b9bfc 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -519,7 +519,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>  	sum_folio = f2fs_get_sum_folio(sbi, segno);
>  	if (IS_ERR(sum_folio))
>  		return PTR_ERR(sum_folio);
> -	sum_node = folio_address(sum_folio);
> +	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, segno);
>  	sum = sum_node->entries[blkoff];
>  	f2fs_folio_put(sum_folio, true);
>  got_it:
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45eace879d7..77aa2125b8ca 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2712,7 +2712,10 @@ struct folio *f2fs_get_sum_folio(struct f2fs_sb_info *sbi, unsigned int segno)
>  void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
>  					void *src, block_t blk_addr)
>  {
> -	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
> +	struct folio *folio = f2fs_get_meta_folio_retry(sbi, blk_addr);
> +
> +	if (IS_ERR(folio))
> +		return;
>  
>  	memcpy(folio_address(folio), src, PAGE_SIZE);
>  	folio_mark_dirty(folio);
> @@ -2720,9 +2723,17 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
>  }
>  
>  static void write_sum_page(struct f2fs_sb_info *sbi,
> -			struct f2fs_summary_block *sum_blk, block_t blk_addr)
> +		struct f2fs_summary_block *sum_blk, unsigned int segno)
>  {
> -	f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
> +	struct folio *folio;
> +
> +	folio = f2fs_get_sum_folio(sbi, segno);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_blk));
> +	folio_mark_dirty(folio);
> +	f2fs_folio_put(folio, true);
>  }
>  
>  static void write_current_sum_page(struct f2fs_sb_info *sbi,
> @@ -2987,7 +2998,7 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>  	int ret;
>  
>  	if (curseg->inited)
> -		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
> +		write_sum_page(sbi, curseg->sum_blk, segno);
>  
>  	segno = __get_next_segno(sbi, type);
>  	ret = get_new_segment(sbi, &segno, new_sec, pinning);
> @@ -3046,7 +3057,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
>  	struct folio *sum_folio;
>  
>  	if (curseg->inited)
> -		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, curseg->segno));
> +		write_sum_page(sbi, curseg->sum_blk, curseg->segno);
>  
>  	__set_test_and_inuse(sbi, new_segno);
>  
> @@ -3065,7 +3076,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
>  		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
>  		return PTR_ERR(sum_folio);
>  	}
> -	sum_node = folio_address(sum_folio);
> +	sum_node = SUM_BLK_PAGE_ADDR(sum_folio, new_segno);
>  	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
>  	f2fs_folio_put(sum_folio, true);
>  	return 0;
> @@ -3154,8 +3165,7 @@ static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
>  		goto out;
>  
>  	if (get_valid_blocks(sbi, curseg->segno, false)) {
> -		write_sum_page(sbi, curseg->sum_blk,
> -				GET_SUM_BLOCK(sbi, curseg->segno));
> +		write_sum_page(sbi, curseg->sum_blk, curseg->segno);
>  	} else {
>  		mutex_lock(&DIRTY_I(sbi)->seglist_lock);
>  		__set_test_and_free(sbi, curseg->segno, true);
> @@ -3833,8 +3843,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
>  	if (segment_full) {
>  		if (type == CURSEG_COLD_DATA_PINNED &&
>  		    !((curseg->segno + 1) % sbi->segs_per_sec)) {
> -			write_sum_page(sbi, curseg->sum_blk,
> -					GET_SUM_BLOCK(sbi, curseg->segno));
> +			write_sum_page(sbi, curseg->sum_blk, curseg->segno);
>  			reset_curseg_fields(curseg);
>  			goto skip_new_segment;
>  		}
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 1ce2c8abaf48..e883f14c228f 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -85,8 +85,12 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  #define GET_ZONE_FROM_SEG(sbi, segno)				\
>  	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
>  
> -#define GET_SUM_BLOCK(sbi, segno)				\
> -	((sbi)->sm_info->ssa_blkaddr + (segno))
> +#define SUMS_PER_BLOCK (F2FS_BLKSIZE / F2FS_SUM_BLKSIZE)
> +#define GET_SUM_BLOCK(sbi, segno)	\
> +	(SM_I(sbi)->ssa_blkaddr + (segno / SUMS_PER_BLOCK))
> +#define GET_SUM_BLKOFF(segno) (segno % SUMS_PER_BLOCK)
> +#define SUM_BLK_PAGE_ADDR(folio, segno)	\
> +	(folio_address(folio) + GET_SUM_BLKOFF(segno) * F2FS_SUM_BLKSIZE)
>  
>  #define GET_SUM_TYPE(footer) ((footer)->entry_type)
>  #define SET_SUM_TYPE(footer, type) ((footer)->entry_type = (type))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6e52e36c1f1a..5c323850e298 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4052,6 +4052,44 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  	if (sanity_check_area_boundary(sbi, folio, index))
>  		return -EFSCORRUPTED;
>  
> +	/*
> +	 * Check for legacy summary layout on 16KB+ block devices.
> +	 * Modern f2fs-tools packs multiple 4KB summary areas into one block,
> +	 * whereas legacy versions used one block per summary, leading
> +	 * to a much larger SSA.
> +	 */
> +	if (SUMS_PER_BLOCK > 1) {
> +		unsigned int required_ssa_blocks;
> +		unsigned int expected_ssa_segs;
> +		unsigned int total_meta_segments, diff;
> +		unsigned int segment_count_ssa =
> +			le32_to_cpu(raw_super->segment_count_ssa);
> +		unsigned int segs_per_zone = segs_per_sec * secs_per_zone;
> +
> +		required_ssa_blocks = DIV_ROUND_UP(segment_count_main,
> +							SUMS_PER_BLOCK);
> +		expected_ssa_segs = DIV_ROUND_UP(required_ssa_blocks,
> +							blocks_per_seg);
> +		total_meta_segments =
> +			le32_to_cpu(raw_super->segment_count_ckpt) +
> +			le32_to_cpu(raw_super->segment_count_sit) +
> +			le32_to_cpu(raw_super->segment_count_nat) +
> +			expected_ssa_segs;
> +		diff = total_meta_segments % segs_per_zone;
> +		if (diff)
> +			expected_ssa_segs += segs_per_zone - diff;
> +
> +		if (segment_count_ssa > expected_ssa_segs) {

Daeho,

Not sure, for an extreme small-sized image, e.g. 64MB, at most, filesystem
has 32 segments, so 32 summary blocks are enough? Then, segment_count_ssa and
expected_ssa_segs could be the same (one segment)? Or am I missing something?

Thanks,

> +			f2fs_info(sbi, "Error: Device formatted with a legacy "
> +					"version. Please reformat.");
> +			f2fs_info(sbi, "\tSSA segment count (%u) is larger "
> +					"than expected (%u) for block "
> +					"size (%lu).", segment_count_ssa,
> +					expected_ssa_segs, F2FS_BLKSIZE);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 6afb4a13b81d..a7880787cad3 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -17,6 +17,7 @@
>  #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
>  #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
>  #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
> +#define F2FS_SUM_BLKSIZE		4096	/* only support 4096 byte sum block */
>  #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
>  #define F2FS_EXTENSION_LEN		8	/* max size of extension */
>  
> @@ -441,7 +442,7 @@ struct f2fs_sit_block {
>   * from node's page's beginning to get a data block address.
>   * ex) data_blkaddr = (block_t)(nodepage_start_address + ofs_in_node)
>   */
> -#define ENTRIES_IN_SUM		(F2FS_BLKSIZE / 8)
> +#define ENTRIES_IN_SUM		(F2FS_SUM_BLKSIZE / 8)
>  #define	SUMMARY_SIZE		(7)	/* sizeof(struct f2fs_summary) */
>  #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
>  #define SUM_ENTRY_SIZE		(SUMMARY_SIZE * ENTRIES_IN_SUM)
> @@ -467,7 +468,7 @@ struct summary_footer {
>  	__le32 check_sum;		/* summary checksum */
>  } __packed;
>  
> -#define SUM_JOURNAL_SIZE	(F2FS_BLKSIZE - SUM_FOOTER_SIZE -\
> +#define SUM_JOURNAL_SIZE	(F2FS_SUM_BLKSIZE - SUM_FOOTER_SIZE -\
>  				SUM_ENTRY_SIZE)
>  #define NAT_JOURNAL_ENTRIES	((SUM_JOURNAL_SIZE - 2) /\
>  				sizeof(struct nat_journal_entry))


