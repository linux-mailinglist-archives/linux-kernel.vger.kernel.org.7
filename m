Return-Path: <linux-kernel+bounces-821934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED20B82A48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E813F16A6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396E20299B;
	Thu, 18 Sep 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FXmRR6vb"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488F17E0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162156; cv=none; b=WdSU7RySBbyuk+8XRE8xOheUzhAZi1g2pk8Ef4xXFzrCGYEJ5pZU70PcNnKBCgCIWMfVNk4sRp3yQxP8orH1fTnkDQ96X9TRNi02wgEj4mqq4eYVTuav0mspglljEbXfXkke7szeYnZy8tmtwcVeaN+hSqytuQDNaYJZsHfUP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162156; c=relaxed/simple;
	bh=Z70RKGWOSmrPqngAIH2L/wZrjvLLNE4NFbMxQJwqyss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfI8dHxSs+wdyXw/OEfEL3WpCEA4Q1g9ngB4tDwmJ4XgJ0ensLmGKWFDLjf9CFrE+s7iysogI4FoibWfs56/tvfBuRPqS6hIPISB5UlqkUlFWKm4427u5j/GD3VbrXhf/HVbd7g4I+JKs+Hoj3mdcPuG/LxWvQaCCX/9KuiTHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FXmRR6vb; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758162146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AUgmNLpciY51XRiDAlwpEoWyC0Ozy4WSZRgjpXt9VkE=;
	b=FXmRR6vbzlUkOllk6lCB2RUWTDZGFKS2kzhNEx4GrBM+0Uqm2uvKXZ8pDqOJph2rZfdf+ayAYaX5osT8OtTu9Eu6nmXmzAEFuh+D5DVp+I8noRwPtZmcxD1LrObagSg8soX4JKGhuPaWmYCo3yGGBDgNNgHTKAZbnAtnmODutIw=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoEIrkb_1758162143 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 10:22:24 +0800
Message-ID: <122ec2b9-8f0f-4184-a15b-8f3ccbd336ea@linux.alibaba.com>
Date: Thu, 18 Sep 2025 10:22:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, david@redhat.com, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
 <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
 <9b01a2cc-7cdb-e008-f5bc-ff9aa313621a@google.com>
 <6ebb5cd0-0897-4de7-9303-422d0caa18cb@linux.alibaba.com>
 <7eace9f6-e257-498d-ac10-ae86b5713e3a@linux.alibaba.com>
 <1111883c-974f-e4da-a38f-bb3d337185ad@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1111883c-974f-e4da-a38f-bb3d337185ad@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/17 15:49, Hugh Dickins wrote:
> On Wed, 17 Sep 2025, Baolin Wang wrote:
>> On 2025/9/16 15:18, Baolin Wang wrote:
> ...
>>>
>>> Additionally, I'm still struggling to understand this case where a folio is
>>> dirty but has a NULL mapping, but I might understand that ext3 journaling
>>> might do this from the comments in truncate_cleanup_folio().
>>>
>>> But I still doubt whether this case exists because the refcount check in
>>> is_page_cache_freeable() considers the pagecache. This means if this dirty
>>> folio's mapping is NULL, the following check would return false. If it
>>> returns true, it means that even if we release the private data here, the
>>> orphaned folio's refcount still doesn't meet the requirements for being
>>> reclaimed. Please correct me if I missed anything.
>>>
>>> static inline int is_page_cache_freeable(struct folio *folio)
>>> {
>>>           /*
>>>            * A freeable page cache folio is referenced only by the caller
>>>            * that isolated the folio, the page cache and optional filesystem
>>>            * private data at folio->private.
>>>            */
>>>           return folio_ref_count(folio) - folio_test_private(folio) ==
>>>                   1 + folio_nr_pages(folio);
>>> }
>>>
> 
> Good point, yes, it's surprising that that such a folio could pass
> that check and reach the code you're proposing to delete.
> 
> (Though a racing scanner of physical memory could raise the refcount
> momentarily, causing the folio to look like a page cache freeable.)
> 
>>
>> I continued to dig into the historical commits, where the private check was
>> introduced in 2005 by commit ce91b575332b ("orphaned pagecache memleak fix"),
>> as the commit message mentioned, it was to address the issue where reiserfs
>> pagecache may be truncated while still pinned:
> 
> Yes, I had been doing the same research, coming to that same 2.6.12 commit,
> one of the last to go in before the birth of git.
> 
>>
>> "
>> Chris found that with data journaling a reiserfs pagecache may be truncate
>> while still pinned.  The truncation removes the page->mapping, but the page is
>> still listed in the VM queues because it still has buffers.  Then during the
>> journaling process, a buffer is marked dirty and that sets the PG_dirty
>> bitflag as well (in mark_buffer_dirty). After that the page is leaked because
>> it's both dirty and without a mapping.
>>
>> So we must allow pages without mapping and dirty to reach the PagePrivate
>> check.  The page->mapping will be checked again right after the PagePrivate
>> check.
>> "
>>
>> In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
>> data=journal") seems to be dealing with a similar issue, where the page
>> becomes dirty after truncation, and provides a very useful call stack:
>> truncate_complete_page()
>>        cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
>>        do_invalidatepage()
>>          ext3_invalidatepage()
>>            journal_invalidatepage()
>>              journal_unmap_buffer()
>>                __dispose_buffer()
>>                  __journal_unfile_buffer()
>>                    __journal_temp_unlink_buffer()
>>                      mark_buffer_dirty(); // PG_dirty set, incr. dirty pages
>>
>> In this fix, we forcefully clear the page's dirty flag during truncation (in
>> truncate_complete_page()).
> 
> But missed that one.
> 
>>
>> However, I am still unsure how the reiserfs case is checked through
>> is_page_cache_freeable() (if the pagecache is truncated, then the pagecache
>> refcount would be decreased). Fortunately, reiserfs was removed in 2024 by
>> commit fb6f20ecb121 ("reiserfs: The last commit").
> 
> I did find a single report of the "pageout: orphaned page" message
> (where Andrew claims the message as his forgotten temporary debugging):
> 
> https://lore.kernel.org/all/20061002170353.GA26816@king.bitgnome.net/
> 
>  From 2006 on 2.6.18: and indeed it was on reiserfs - maybe reiserfs
> had some extra refcounting on these pages, which caused them to pass
> the is_page_cache_freeable() check (but would they actually be freeable,
> or leaked? TBH I haven't tried to work that out, nor care very much).
> 
> Where does this leave us?  I think it says that your deletion of that
> block from pageout() is acceptable now, with reiserfs gone to history.
> 
> Though somehow I would prefer, like that ext3 fix, that we would just
> clear dirty on such a folio (to avoid "Bad page state" later if it is
> freeable), not go to pageout(), but proceed to the folio_needs_release()
> block like for clean folios.
> 
> But whatever: you've persuaded me! I withdraw my objection to your patch.

Thanks for confirming. I will update the commit message based on our 
discussion.

