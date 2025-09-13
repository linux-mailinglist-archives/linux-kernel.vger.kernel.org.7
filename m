Return-Path: <linux-kernel+bounces-815008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BDDB55E17
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C57D5C2235
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F881DDC1D;
	Sat, 13 Sep 2025 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yH9PLmyl"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C101B3923
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757733884; cv=none; b=otUT8kR7F0vBrGZxpmsQAZUiDOiEFzUITsQObaGeCRGtWK/9pmOO5ZgPRdxmLpeLqJLpwoRfe5scS+s2YQ3KsugFn9IFrmgeQAwBP7Hym2ci1jbzeGC2H2dFOYZwP/ooLsXMMsSQueEtuJsG28hVSPKRr2Pv1/zqLeR82BGLVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757733884; c=relaxed/simple;
	bh=0Sn9sxuDaV23bRoeVHpyAg8lrq5GnVUrVMrAJKip6Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6tRlBbOMhqnxKJFhCUngFwUbW90kgGnwPCYvvvaRuF3OwcgBdymRuiUEmqlN+qbMiT6OELSuiT7nkaNuSCRcPU9L6CyJOUT346pG7/cMctVcERQviuLxI6J28X8P90TPCHITuRle+18LxVocf9Xuo4NwMp34z9Q5WDMU2EkfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yH9PLmyl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757733878; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q3I2VSj+5/i2iRYQrnjqI4t6HKmkDRL5/Des0wQPmt0=;
	b=yH9PLmylriUj9VqbspoQOvmpuryyRoKtXr9xRNbI/4FLU3hawTdBX4yRbludJZH7YAMxp8/5zmnCq4c18ysRinjmEkN/gbNvNzEfnl1a9rVKAVQkMe7Gx5wSN+Yf2h4uxWPBIo9rf/jM52rM35ymbNS6i7KMTgN2VTUcYHT5hV8=
Received: from 30.134.50.220(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnsej1J_1757733876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 11:24:36 +0800
Message-ID: <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
Date: Sat, 13 Sep 2025 11:24:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 hughd@google.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/13 00:13, Shakeel Butt wrote:
> On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
>> Currently, we no longer attempt to write back filesystem folios in pageout(),
>> and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
>> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
>> which means no fs-private private data is used. Therefore, we can remove the
>> redundant folio_test_private() checks and related buffer_head release logic.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/vmscan.c | 16 +---------------
>>   1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f1fc36729ddd..8056fccb9cc4 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>>   	 * swap_backing_dev_info is bust: it doesn't reflect the
>>   	 * congestion state of the swapdevs.  Easy to fix, if needed.
>>   	 */
>> -	if (!is_page_cache_freeable(folio))
>> +	if (!is_page_cache_freeable(folio) || !mapping)
>>   		return PAGE_KEEP;
>> -	if (!mapping) {
>> -		/*
>> -		 * Some data journaling orphaned folios can have
>> -		 * folio->mapping == NULL while being dirty with clean buffers.
>> -		 */
> 
> Can this case not happen anymore and try_to_free_buffers is not needed?

For dirty file folios, pageout() will return PAGE_KEEP and put them back 
on the LRU list. So even if mapping = NULL, background workers for 
writeback will continue to handle them, rather than in shrink_folio_list().

For clean file folios, the !mapping case will be be handled later in 
shrink_folio_list(), please see the following comments:

/*
  * If the folio has buffers, try to free the buffer
  * mappings associated with this folio. If we succeed
  * we try to free the folio as well.
  *
  * We do this even if the folio is dirty.
  * filemap_release_folio() does not perform I/O, but it
  * is possible for a folio to have the dirty flag set,
  * but it is actually clean (all its buffers are clean).
  * This happens if the buffers were written out directly,
  * with submit_bh(). ext3 will do this, as well as
  * the blockdev mapping.  filemap_release_folio() will
  * discover that cleanness and will drop the buffers
  * and mark the folio clean - it can be freed.
  *
  * Rarely, folios can have buffers and no ->mapping.
  * These are the folios which were not successfully
  * invalidated in truncate_cleanup_folio().  We try to
  * drop those buffers here and if that worked, and the
  * folio is no longer mapped into process address space
  * (refcount == 1) it can be freed.  Otherwise, leave
  * the folio on the LRU so it is swappable.
  */

>> -		if (folio_test_private(folio)) {
>> -			if (try_to_free_buffers(folio)) {
>> -				folio_clear_dirty(folio);
>> -				pr_info("%s: orphaned folio\n", __func__);
>> -				return PAGE_CLEAN;
>> -			}
>> -		}
>> -		return PAGE_KEEP;
>> -	}
>>   
>>   	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
>>   		return PAGE_ACTIVATE;
>> -- 
>> 2.43.7
>>


