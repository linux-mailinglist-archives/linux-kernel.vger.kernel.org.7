Return-Path: <linux-kernel+bounces-597094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD2A83511
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 02:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E528C1035
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4015E90;
	Thu, 10 Apr 2025 00:18:15 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA22182D7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744244295; cv=none; b=CYGAa4JiMqOxR0dN3M5Ws5uvA7KbI02dDCEHSOPODIPqkck89xtK8vjeDKk40S4k1oANWUPC56t9Xy9KrLrrkGYlSGEhDFFhf6k7cWeCcH/rivNQaMKYZNSRyNX35/StE5zqbDjmnqYCAgF/CECUd2TqZ7U+f4abE3PP/ezVu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744244295; c=relaxed/simple;
	bh=VggCcT9r7p5amX4EWvIx82pAuKYSrM5BGUSj6Hb5ip8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAe9YFvdKRgGAK97HX8d28xHej6fNEOfYILy75X/9HmGLZQqRRLicNy/CmEIit+a5QRn0tb7PqpXE9IVKdk6XJOgCG9GlznAd+1uc09tzQFbjM+sfYYCeLMuchhZuEY3U4hTTtzje9/Yom06ROGwYAg3bd2DCMCxuFa2Sk00AqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-057ff7000000aab6-a2-67f70e389bd3
From: "yohan.joung" <yohan.joung@sk.com>
To: "yohan.joung" <yohan.joung@sk.com>
Cc: pilhyun.kim@sk.com,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Improve large section GC by locating valid block segments
Date: Thu, 10 Apr 2025 09:17:15 +0900
Message-ID: <20250410001747.1844-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250327084620.2152-1-yohan.joung@sk.com> (raw)
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC9ZZnoa4F3/d0gwVTVC1OTz3LZPHmyBkW
	iyfrZzFbXFrkbnF51xw2B1aPnbPusntsWtXJ5rF7wWcmj8+b5AJYorhsUlJzMstSi/TtErgy
	9nYtZC044lVxb1c/cwPjB+suRk4OCQETiZMzDzLC2MvXXGEHsdkENCT+9PYyg9giAmoSy1++
	B6rh4mAWmMcose7WdbAGYYEkiSeXz7J2MXJwsAioSsw85A8S5hUwk7gwaS0bxExNiR1fzjOB
	lHAK2Eqs6ZMHCQsJ8Ei82rCfEaJcEOiEJywgNrOAvETz1tnMIKskBCawSWx+3gI1R1Li4Iob
	LBMY+Wch6ZmFpGcBI9MqRpHMvLLcxMwcY73i7IzKvMwKveT83E2MwIBcVvsncgfjtwvBhxgF
	OBiVeHg9Mr6lC7EmlhVX5h5ilOBgVhLhnZAHFOJNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08
	RUggPbEkNTs1tSC1CCbLxMEp1cAoX7N5xaEiNqcApr1eGTO2hj2a9Xh/yjwb6xg1zu398lcb
	vnRMvL4zQ1ksI/RP3acVWTLLF0s0P3PfaurMXt469a/DkelOqfZ3t1m+2Tr9TqXCdf8LjdM3
	VF+vT5twm6/muGTybsmAfxO0UpPs+I4ufHJuRj6zkmGsT0Tznde2bz5MS+XVT8pVYinOSDTU
	Yi4qTgQAmLVfU0QCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsXCNUNljq4F3/d0gzObZSxOTz3LZPHmyBkW
	iyfrZzFbXFrkbnF51xw2iwlzrzJZvN96j9GB3WPnrLvsHptWdbJ57F7wmcnj220Pj8+b5AJY
	o7hsUlJzMstSi/TtErgy9nYtZC044lVxb1c/cwPjB+suRk4OCQETieVrrrCD2GwCGhJ/enuZ
	QWwRATWJ5S/fM3YxcnEwC8xjlFh36zojSEJYIEniyeWzrF2MHBwsAqoSMw/5g4R5BcwkLkxa
	ywYxU1Nix5fzTCAlnAK2Emv65EHCQgI8Eq827GeEKBeUODnzCQuIzSwgL9G8dTbzBEaeWUhS
	s5CkFjAyrWIUycwry03MzDHTK87OqMzLrNBLzs/dxAgMsWW1fybtYPx22f0QowAHoxIPr0fG
	t3Qh1sSy4srcQ4wSHMxKIrwT8oBCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1Kz
	U1MLUotgskwcnFINjOLOZwxF05MC3cOa53RmXrvcMyu+lWWz9M6tt33P3GWs//Pu1/dbh97k
	bfmry7/jh1ue8bU+ndp/f61VFKPmrJuzOTi/7t4/ka8S03tC9q8+l3nMbIvvPkmJQ68jrpVy
	5XEK/J88N/vD86WXOq8Jzv/8Mrnh46qygk2hWyy7dZfzKwf++1gaOVWJpTgj0VCLuag4EQC8
	b0G1LQIAAA==
X-CFilter-Loop: Reflected

hi jeageuk, chao 
How about changing the large section gc in this direction?
Thanks

> Change the large section GC to locate valid block segments instead of
> performing a sequential search. This modification enhances performance
> by reducing unnecessary block scanning in large storage sections.
> 
> example :
> [invalid seg 0] [invalid seg 1] [invalid seg 2]
> [  valid seg 3] [  valid seg 4] [  valid seg 5]
> 
> Current: In the first GC, nothing is moved,
> but in the second GC, segments 3, 4, and 5 are moved.
> Change: In the first GC, segments 3, 4, and 5 are moved.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/f2fs.h  |  2 ++
>  fs/f2fs/gc.c    | 92 +++++++++++++++++++++++++++++++++++--------------
>  fs/f2fs/gc.h    |  6 ++++
>  fs/f2fs/super.c |  8 ++++-
>  4 files changed, 82 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1576dc6ec67..348417edac25 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4008,6 +4008,8 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>  int f2fs_resize_fs(struct file *filp, __u64 block_count);
>  int __init f2fs_create_garbage_collection_cache(void);
>  void f2fs_destroy_garbage_collection_cache(void);
> +int __init f2fs_init_garbage_collection_summary_cache(void);
> +void f2fs_destroy_garbage_collection_summary_cache(void);
>  /* victim selection function for cleaning and SSR */
>  int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>  			int gc_type, int type, char alloc_mode,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 2b8f9239bede..3b63e85fa038 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -24,6 +24,7 @@
>  #include <trace/events/f2fs.h>
>  
>  static struct kmem_cache *victim_entry_slab;
> +static struct kmem_cache *gc_page_entry_slab;
>  
>  static unsigned int count_bits(const unsigned long *addr,
>  				unsigned int offset, unsigned int len);
> @@ -711,6 +712,30 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
>  	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
>  }
>  
> +static struct gc_page_entry *add_gc_page_entry(struct list_head *gc_page_list,
> +					struct page *sum_page, unsigned int segno)
> +{
> +	struct gc_page_entry *gpe;
> +
> +	gpe = f2fs_kmem_cache_alloc(gc_page_entry_slab, GFP_NOFS, true, NULL);
> +	gpe->segno = segno;
> +	gpe->sum_page = sum_page;
> +	list_add_tail(&gpe->list, gc_page_list);
> +	return gpe;
> +}
> +
> +static void release_gc_page_entry(struct list_head *gc_page_list, bool putpage)
> +{
> +	struct gc_page_entry *gpe, *tmp;
> +
> +	list_for_each_entry_safe(gpe, tmp, gc_page_list, list) {
> +		if (putpage)
> +			f2fs_put_page(gpe->sum_page, 0);
> +		list_del(&gpe->list);
> +		kmem_cache_free(gc_page_entry_slab, gpe);
> +	}
> +}
> +
>  static bool f2fs_pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
>  {
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> @@ -1721,14 +1746,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  	struct page *sum_page;
>  	struct f2fs_summary_block *sum;
>  	struct blk_plug plug;
> +	struct gc_page_entry *gpe;
>  	unsigned int segno = start_segno;
>  	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
>  	unsigned int sec_end_segno;
> +	unsigned int window_granularity = 1;
>  	int seg_freed = 0, migrated = 0;
>  	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>  						SUM_TYPE_DATA : SUM_TYPE_NODE;
>  	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
>  	int submitted = 0;
> +	int gc_list_count = 0;
> +	LIST_HEAD(gc_page_list);
>  
>  	if (__is_large_section(sbi)) {
>  		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
> @@ -1744,7 +1773,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  					f2fs_usable_segs_in_sec(sbi);
>  
>  		if (gc_type == BG_GC || one_time) {
> -			unsigned int window_granularity =
> +			window_granularity =
>  				sbi->migration_window_granularity;
>  
>  			if (f2fs_sb_has_blkzoned(sbi) &&
> @@ -1752,8 +1781,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  					sbi->gc_thread->boost_zoned_gc_percent))
>  				window_granularity *=
>  					BOOST_GC_MULTIPLE;
> -
> -			end_segno = start_segno + window_granularity;
>  		}
>  
>  		if (end_segno > sec_end_segno)
> @@ -1762,37 +1789,38 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  
>  	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
>  
> -	/* readahead multi ssa blocks those have contiguous address */
> -	if (__is_large_section(sbi))
> +	for (segno = start_segno; segno < end_segno; segno++) {
> +		if (!get_valid_blocks(sbi, segno, false))
> +			continue;
> +
> +		/* readahead multi ssa blocks those have contiguous address */
>  		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
> -					end_segno - segno, META_SSA, true);
> +				window_granularity, META_SSA, true);
>  
> -	/* reference all summary page */
> -	while (segno < end_segno) {
> -		sum_page = f2fs_get_sum_page(sbi, segno++);
> +		/* reference all summary page */
> +		sum_page = f2fs_get_sum_page(sbi, segno);
>  		if (IS_ERR(sum_page)) {
>  			int err = PTR_ERR(sum_page);
> -
> -			end_segno = segno - 1;
> -			for (segno = start_segno; segno < end_segno; segno++) {
> -				sum_page = find_get_page(META_MAPPING(sbi),
> -						GET_SUM_BLOCK(sbi, segno));
> -				f2fs_put_page(sum_page, 0);
> -				f2fs_put_page(sum_page, 0);
> -			}
> +			release_gc_page_entry(&gc_page_list, true);
>  			return err;
>  		}
> +		add_gc_page_entry(&gc_page_list, sum_page, segno);
>  		unlock_page(sum_page);
> +		if (++gc_list_count >= window_granularity)
> +			break;
>  	}
>  
>  	blk_start_plug(&plug);
>  
> -	for (segno = start_segno; segno < end_segno; segno++) {
> +	list_for_each_entry(gpe, &gc_page_list, list) {
>  
>  		/* find segment summary of victim */
> -		sum_page = find_get_page(META_MAPPING(sbi),
> -					GET_SUM_BLOCK(sbi, segno));
> -		f2fs_put_page(sum_page, 0);
> +		sum_page = gpe->sum_page;
> +		segno = gpe->segno;
> +		if (!sum_page) {
> +			f2fs_err(sbi, "Failed to get summary page for segment %u", segno);
> +			goto skip;
> +		}
>  
>  		if (get_valid_blocks(sbi, segno, false) == 0)
>  			goto freed;
> @@ -1835,18 +1863,20 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  				get_valid_blocks(sbi, segno, false) == 0)
>  			seg_freed++;
>  
> -		if (__is_large_section(sbi))
> -			sbi->next_victim_seg[gc_type] =
> -				(segno + 1 < sec_end_segno) ?
> -					segno + 1 : NULL_SEGNO;
>  skip:
>  		f2fs_put_page(sum_page, 0);
>  	}
>  
> +	if (__is_large_section(sbi) && !list_empty(&gc_page_list))
> +		sbi->next_victim_seg[gc_type] =
> +			(segno + 1 < sec_end_segno) ?
> +				segno + 1 : NULL_SEGNO;
> +
>  	if (submitted)
>  		f2fs_submit_merged_write(sbi, data_type);
>  
>  	blk_finish_plug(&plug);
> +	release_gc_page_entry(&gc_page_list, false);
>  
>  	if (migrated)
>  		stat_inc_gc_sec_count(sbi, data_type, gc_type);
> @@ -2008,6 +2038,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  	return ret;
>  }
>  
> +int __init f2fs_init_garbage_collection_summary_cache(void)
> +{
> +	gc_page_entry_slab = f2fs_kmem_cache_create("f2fs_gc_page_entry",
> +					sizeof(struct gc_page_entry));
> +	return gc_page_entry_slab ? 0 : -ENOMEM;
> +}
> +
> +void f2fs_destroy_garbage_collection_summary_cache(void)
> +{
> +	kmem_cache_destroy(gc_page_entry_slab);
> +}
> +
>  int __init f2fs_create_garbage_collection_cache(void)
>  {
>  	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 5c1eaf55e127..9c8695efe394 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -82,6 +82,12 @@ struct victim_entry {
>  	struct list_head list;
>  };
>  
> +struct gc_page_entry {
> +	unsigned int segno;
> +	struct page *sum_page;
> +	struct list_head list;
> +};
> +
>  /*
>   * inline functions
>   */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f087b2b71c89..a3241730fe4f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5090,9 +5090,12 @@ static int __init init_f2fs_fs(void)
>  	err = f2fs_create_garbage_collection_cache();
>  	if (err)
>  		goto free_extent_cache;
> -	err = f2fs_init_sysfs();
> +	err = f2fs_init_garbage_collection_summary_cache();
>  	if (err)
>  		goto free_garbage_collection_cache;
> +	err = f2fs_init_sysfs();
> +	if (err)
> +		goto free_garbage_collection_summary_cache;
>  	err = f2fs_init_shrinker();
>  	if (err)
>  		goto free_sysfs;
> @@ -5141,6 +5144,8 @@ static int __init init_f2fs_fs(void)
>  	f2fs_exit_shrinker();
>  free_sysfs:
>  	f2fs_exit_sysfs();
> +free_garbage_collection_summary_cache:
> +	f2fs_destroy_garbage_collection_summary_cache();
>  free_garbage_collection_cache:
>  	f2fs_destroy_garbage_collection_cache();
>  free_extent_cache:
> @@ -5172,6 +5177,7 @@ static void __exit exit_f2fs_fs(void)
>  	f2fs_destroy_root_stats();
>  	f2fs_exit_shrinker();
>  	f2fs_exit_sysfs();
> +	f2fs_destroy_garbage_collection_summary_cache();
>  	f2fs_destroy_garbage_collection_cache();
>  	f2fs_destroy_extent_cache();
>  	f2fs_destroy_recovery_cache();
> -- 
> 2.33.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net

