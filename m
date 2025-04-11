Return-Path: <linux-kernel+bounces-599920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE0A85929
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E481B8171A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D9F29AAFD;
	Fri, 11 Apr 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6FMzvCZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8729AB0A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366033; cv=none; b=CCBY0n6TOujTbrI6cIXtFJCQD4DViQnJwCOXCzYAAJfoOx1ACTzbZ0dyqy60diiZ5pFLqdf9WaKPk1IL4OHjGxIpf6TmKP7/pawO6pGg+bljQViCZyv/TsdcLhrCl5+LcFcKChv7hiUvPylxMlVSwNY7L3wPCezAFvjcZCZVmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366033; c=relaxed/simple;
	bh=zog6+A4bgw41mwmAj6LyqLPSAxuQKdxXwCOjw49nIK8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y4PpuhoseOe24wIGF6eRvasGkpSF+VoySDWMk056eO12oWzDStIjfothiNi4yEKpD/LfyCyX/OC1UTX52EkjuBg5egk60Uqj7Y7/X+kFu2FrpoXztBEAD48d3jZVacDG+sNwJ3J3HaRCA2Qvic2r/6zYc7CIowKM1K1E7Z4V7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6FMzvCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A5C4CEE2;
	Fri, 11 Apr 2025 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744366032;
	bh=zog6+A4bgw41mwmAj6LyqLPSAxuQKdxXwCOjw49nIK8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=T6FMzvCZcTie4kDjUokrIJ3jvbvbY/L/v5No62p6OonvotilYAET8qCvlwllba9Ez
	 EGI/qofFtMc5FENlcF0XIa5ez/ApZwKtFnBk9o9UDwmIknq2bnotER+/3ueDWqa7u7
	 OpA77z8I71PEMjsKoyijBKIs3ukTDLIf7FKRK8mtNGFJBl50xDfY42ev0AoPlzXb9t
	 YpvR90aJGBiz8ruQvetgz97r7agScgMiJyWkoguupJGhjNOO08YV+9zIlErwRIOL03
	 cNj/0WK6FJ8Fjg88vaVFyll6De4xHjx+vz82XZ6i5zxjVmCu0vLssk8OaVA1wGgzA2
	 LuqthIwCzwY+w==
Message-ID: <de198b35-fdfd-4fe9-98b9-bb346a81b54c@kernel.org>
Date: Fri, 11 Apr 2025 18:07:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, pilhyun.kim@sk.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, daeho43@gmail.com
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Improve large section GC by locating
 valid block segments
To: "yohan.joung" <yohan.joung@sk.com>
References: <20250410001747.1844-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250410001747.1844-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yohan,

Sorry for the delay, will catch up this a little bit latter.

On 2025/4/10 8:17, yohan.joung wrote:
> hi jeageuk, chao
> How about changing the large section gc in this direction?
> Thanks
> 
>> Change the large section GC to locate valid block segments instead of
>> performing a sequential search. This modification enhances performance
>> by reducing unnecessary block scanning in large storage sections.
>>
>> example :
>> [invalid seg 0] [invalid seg 1] [invalid seg 2]
>> [  valid seg 3] [  valid seg 4] [  valid seg 5]
>>
>> Current: In the first GC, nothing is moved,
>> but in the second GC, segments 3, 4, and 5 are moved.
>> Change: In the first GC, segments 3, 4, and 5 are moved.
>>
>> Signed-off-by: yohan.joung <yohan.joung@sk.com>
>> ---
>>   fs/f2fs/f2fs.h  |  2 ++
>>   fs/f2fs/gc.c    | 92 +++++++++++++++++++++++++++++++++++--------------
>>   fs/f2fs/gc.h    |  6 ++++
>>   fs/f2fs/super.c |  8 ++++-
>>   4 files changed, 82 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f1576dc6ec67..348417edac25 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4008,6 +4008,8 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>>   int f2fs_resize_fs(struct file *filp, __u64 block_count);
>>   int __init f2fs_create_garbage_collection_cache(void);
>>   void f2fs_destroy_garbage_collection_cache(void);
>> +int __init f2fs_init_garbage_collection_summary_cache(void);
>> +void f2fs_destroy_garbage_collection_summary_cache(void);
>>   /* victim selection function for cleaning and SSR */
>>   int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
>>   			int gc_type, int type, char alloc_mode,
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 2b8f9239bede..3b63e85fa038 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -24,6 +24,7 @@
>>   #include <trace/events/f2fs.h>
>>   
>>   static struct kmem_cache *victim_entry_slab;
>> +static struct kmem_cache *gc_page_entry_slab;
>>   
>>   static unsigned int count_bits(const unsigned long *addr,
>>   				unsigned int offset, unsigned int len);
>> @@ -711,6 +712,30 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
>>   	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
>>   }
>>   
>> +static struct gc_page_entry *add_gc_page_entry(struct list_head *gc_page_list,
>> +					struct page *sum_page, unsigned int segno)
>> +{
>> +	struct gc_page_entry *gpe;
>> +
>> +	gpe = f2fs_kmem_cache_alloc(gc_page_entry_slab, GFP_NOFS, true, NULL);
>> +	gpe->segno = segno;
>> +	gpe->sum_page = sum_page;
>> +	list_add_tail(&gpe->list, gc_page_list);
>> +	return gpe;
>> +}
>> +
>> +static void release_gc_page_entry(struct list_head *gc_page_list, bool putpage)
>> +{
>> +	struct gc_page_entry *gpe, *tmp;
>> +
>> +	list_for_each_entry_safe(gpe, tmp, gc_page_list, list) {
>> +		if (putpage)
>> +			f2fs_put_page(gpe->sum_page, 0);
>> +		list_del(&gpe->list);
>> +		kmem_cache_free(gc_page_entry_slab, gpe);
>> +	}
>> +}
>> +
>>   static bool f2fs_pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
>>   {
>>   	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>> @@ -1721,14 +1746,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>   	struct page *sum_page;
>>   	struct f2fs_summary_block *sum;
>>   	struct blk_plug plug;
>> +	struct gc_page_entry *gpe;
>>   	unsigned int segno = start_segno;
>>   	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
>>   	unsigned int sec_end_segno;
>> +	unsigned int window_granularity = 1;
>>   	int seg_freed = 0, migrated = 0;
>>   	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>>   						SUM_TYPE_DATA : SUM_TYPE_NODE;
>>   	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
>>   	int submitted = 0;
>> +	int gc_list_count = 0;
>> +	LIST_HEAD(gc_page_list);
>>   
>>   	if (__is_large_section(sbi)) {
>>   		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
>> @@ -1744,7 +1773,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>   					f2fs_usable_segs_in_sec(sbi);
>>   
>>   		if (gc_type == BG_GC || one_time) {
>> -			unsigned int window_granularity =
>> +			window_granularity =
>>   				sbi->migration_window_granularity;
>>   
>>   			if (f2fs_sb_has_blkzoned(sbi) &&
>> @@ -1752,8 +1781,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>   					sbi->gc_thread->boost_zoned_gc_percent))
>>   				window_granularity *=
>>   					BOOST_GC_MULTIPLE;
>> -
>> -			end_segno = start_segno + window_granularity;
>>   		}
>>   
>>   		if (end_segno > sec_end_segno)
>> @@ -1762,37 +1789,38 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>   
>>   	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
>>   
>> -	/* readahead multi ssa blocks those have contiguous address */
>> -	if (__is_large_section(sbi))
>> +	for (segno = start_segno; segno < end_segno; segno++) {
>> +		if (!get_valid_blocks(sbi, segno, false))
>> +			continue;
>> +
>> +		/* readahead multi ssa blocks those have contiguous address */
>>   		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
>> -					end_segno - segno, META_SSA, true);
>> +				window_granularity, META_SSA, true);
>>   
>> -	/* reference all summary page */
>> -	while (segno < end_segno) {
>> -		sum_page = f2fs_get_sum_page(sbi, segno++);
>> +		/* reference all summary page */
>> +		sum_page = f2fs_get_sum_page(sbi, segno);
>>   		if (IS_ERR(sum_page)) {
>>   			int err = PTR_ERR(sum_page);
>> -
>> -			end_segno = segno - 1;
>> -			for (segno = start_segno; segno < end_segno; segno++) {
>> -				sum_page = find_get_page(META_MAPPING(sbi),
>> -						GET_SUM_BLOCK(sbi, segno));
>> -				f2fs_put_page(sum_page, 0);
>> -				f2fs_put_page(sum_page, 0);
>> -			}
>> +			release_gc_page_entry(&gc_page_list, true);
>>   			return err;
>>   		}
>> +		add_gc_page_entry(&gc_page_list, sum_page, segno);
>>   		unlock_page(sum_page);
>> +		if (++gc_list_count >= window_granularity)
>> +			break;
>>   	}
>>   
>>   	blk_start_plug(&plug);
>>   
>> -	for (segno = start_segno; segno < end_segno; segno++) {
>> +	list_for_each_entry(gpe, &gc_page_list, list) {
>>   
>>   		/* find segment summary of victim */
>> -		sum_page = find_get_page(META_MAPPING(sbi),
>> -					GET_SUM_BLOCK(sbi, segno));
>> -		f2fs_put_page(sum_page, 0);
>> +		sum_page = gpe->sum_page;
>> +		segno = gpe->segno;
>> +		if (!sum_page) {
>> +			f2fs_err(sbi, "Failed to get summary page for segment %u", segno);
>> +			goto skip;
>> +		}
>>   
>>   		if (get_valid_blocks(sbi, segno, false) == 0)
>>   			goto freed;
>> @@ -1835,18 +1863,20 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>   				get_valid_blocks(sbi, segno, false) == 0)
>>   			seg_freed++;
>>   
>> -		if (__is_large_section(sbi))
>> -			sbi->next_victim_seg[gc_type] =
>> -				(segno + 1 < sec_end_segno) ?
>> -					segno + 1 : NULL_SEGNO;
>>   skip:
>>   		f2fs_put_page(sum_page, 0);
>>   	}
>>   
>> +	if (__is_large_section(sbi) && !list_empty(&gc_page_list))
>> +		sbi->next_victim_seg[gc_type] =
>> +			(segno + 1 < sec_end_segno) ?
>> +				segno + 1 : NULL_SEGNO;
>> +
>>   	if (submitted)
>>   		f2fs_submit_merged_write(sbi, data_type);
>>   
>>   	blk_finish_plug(&plug);
>> +	release_gc_page_entry(&gc_page_list, false);
>>   
>>   	if (migrated)
>>   		stat_inc_gc_sec_count(sbi, data_type, gc_type);
>> @@ -2008,6 +2038,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>   	return ret;
>>   }
>>   
>> +int __init f2fs_init_garbage_collection_summary_cache(void)
>> +{
>> +	gc_page_entry_slab = f2fs_kmem_cache_create("f2fs_gc_page_entry",
>> +					sizeof(struct gc_page_entry));
>> +	return gc_page_entry_slab ? 0 : -ENOMEM;
>> +}
>> +
>> +void f2fs_destroy_garbage_collection_summary_cache(void)
>> +{
>> +	kmem_cache_destroy(gc_page_entry_slab);
>> +}
>> +
>>   int __init f2fs_create_garbage_collection_cache(void)
>>   {
>>   	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index 5c1eaf55e127..9c8695efe394 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -82,6 +82,12 @@ struct victim_entry {
>>   	struct list_head list;
>>   };
>>   
>> +struct gc_page_entry {
>> +	unsigned int segno;
>> +	struct page *sum_page;
>> +	struct list_head list;
>> +};
>> +
>>   /*
>>    * inline functions
>>    */
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index f087b2b71c89..a3241730fe4f 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -5090,9 +5090,12 @@ static int __init init_f2fs_fs(void)
>>   	err = f2fs_create_garbage_collection_cache();
>>   	if (err)
>>   		goto free_extent_cache;
>> -	err = f2fs_init_sysfs();
>> +	err = f2fs_init_garbage_collection_summary_cache();
>>   	if (err)
>>   		goto free_garbage_collection_cache;
>> +	err = f2fs_init_sysfs();
>> +	if (err)
>> +		goto free_garbage_collection_summary_cache;
>>   	err = f2fs_init_shrinker();
>>   	if (err)
>>   		goto free_sysfs;
>> @@ -5141,6 +5144,8 @@ static int __init init_f2fs_fs(void)
>>   	f2fs_exit_shrinker();
>>   free_sysfs:
>>   	f2fs_exit_sysfs();
>> +free_garbage_collection_summary_cache:
>> +	f2fs_destroy_garbage_collection_summary_cache();
>>   free_garbage_collection_cache:
>>   	f2fs_destroy_garbage_collection_cache();
>>   free_extent_cache:
>> @@ -5172,6 +5177,7 @@ static void __exit exit_f2fs_fs(void)
>>   	f2fs_destroy_root_stats();
>>   	f2fs_exit_shrinker();
>>   	f2fs_exit_sysfs();
>> +	f2fs_destroy_garbage_collection_summary_cache();
>>   	f2fs_destroy_garbage_collection_cache();
>>   	f2fs_destroy_extent_cache();
>>   	f2fs_destroy_recovery_cache();
>> -- 
>> 2.33.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net


