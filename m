Return-Path: <linux-kernel+bounces-823900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A2B87B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122237C08D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAC24111D;
	Fri, 19 Sep 2025 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oHX4to2G"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC119E7F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247950; cv=none; b=NC3hDS2OKg4mSvFnZM2ZhI8Y1cmV9rvpydwOEXB7f8wddGggBBzFIxBirsYNf59UM50WdMdDoWrg8F+1/+eheTQFEEyLzwpwLmTpa/AkBCP0nGODlvVO2R144B7OMYdoZBUmPsimWtRaUEsjMtreDXaiF/b0RxuNix/RdxDTY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247950; c=relaxed/simple;
	bh=V+IiGmNy69YZSWa2z6+ePLi0MW0LW2EXg+YgYtwvyEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKzx0xUL2GrMJYa0CYLTloxllQjoAV5qIPyIgaCd/drB324esz3zehtfZngYpU2GBChrVSbrbhbStH+0UR2pUyLbIm2GKAxWjnRnF7/X1rO7s73OnltvODfBI/lYoCct9MLtZa+7eqEiC0KeAoVsII/OTh0OQPVwisa3GgFFcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oHX4to2G; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758247935; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=m6BSTlEv4BxYzmuMdizgJCn5FFRfQjdUu4Ddm03+goQ=;
	b=oHX4to2GbSvdroH64hl9VjMqlFCKQFdYkY8oDLn/iBiQXpEqWPLODJ7HkMrc36omKrPOFlAL8OVWSd6V3wvzRBYTBeC21iJKYly+XPRsiPdEle+nTkxIV7qQsl6a7weH4LwB1LKunr2vdLV0tEQhat0VlSH6uvNEdRAGd1lbOh4=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoHs.rR_1758247933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 10:12:14 +0800
Message-ID: <787dc1a4-d0b7-4559-8160-55de987beac3@linux.alibaba.com>
Date: Fri, 19 Sep 2025 10:12:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
 <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
 <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com>
 <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
 <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/19 09:06, Shakeel Butt wrote:
> On Thu, Sep 18, 2025 at 05:36:17PM +0800, Baolin Wang wrote:
>>
>>
>> On 2025/9/18 14:00, David Hildenbrand wrote:
>>> On 18.09.25 05:46, Baolin Wang wrote:
>>>> The folio_test_private() check in pageout() was introduced by commit
>>>> ce91b575332b ("orphaned pagecache memleak fix") in 2005 (checked from
>>>> a history tree[1]). As the commit message mentioned, it was to address
>>>> the issue where reiserfs pagecache may be truncated while still pinned.
>>>> To further explain, the truncation removes the page->mapping, but the
>>>> page is still listed in the VM queues because it still has buffers.
>>>>
>>>> In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
>>>> data=journal") seems to be dealing with a similar issue, where the page
>>>> becomes dirty after truncation, and it provides a very useful call stack:
>>>> truncate_complete_page()
>>>>         cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
>>>>         do_invalidatepage()
>>>>           ext3_invalidatepage()
>>>>             journal_invalidatepage()
>>>>               journal_unmap_buffer()
>>>>                 __dispose_buffer()
>>>>                   __journal_unfile_buffer()
>>>>                     __journal_temp_unlink_buffer()
>>>>                       mark_buffer_dirty(); // PG_dirty set, incr.
>>>> dirty pages
>>>>
>>>> In this commit a2b345642f530, we forcefully clear the page's dirty flag
>>>> during truncation (in truncate_complete_page()).
>>>>
>>>> Now it seems this was just a peculiar usage specific to reiserfs. Maybe
>>>> reiserfs had some extra refcount on these pages, which caused them
>>>> to pass
>>>> the is_page_cache_freeable() check. With the fix provided by commit
>>>> a2b345642f530
>>>> and reiserfs being removed in 2024 by commit fb6f20ecb121 ("reiserfs: The
>>>> last commit"), such a case is unlikely to occur again. So let's
>>>> remove the
>>>> redundant folio_test_private() checks and related buffer_head
>>>> release logic,
>>>> and just leave a warning here to catch such a bug.
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/vmscan.c | 12 +++---------
>>>>    1 file changed, 3 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index f1fc36729ddd..930add6d90ab 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio,
>>>> struct address_space *mapping,
>>>>            return PAGE_KEEP;
>>>>        if (!mapping) {
>>>>            /*
>>>> -         * Some data journaling orphaned folios can have
>>>> -         * folio->mapping == NULL while being dirty with clean buffers.
>>>> +         * Is it still possible to have a dirty folio with
>>>> +         * a NULL mapping? I think not.
>>>>             */
>>>
>>> I would rephrase slightly (removing the "I think not"):
>>>
>>> /*
>>>    * We should no longer have dirty folios with clean buffers and a NULL
>>>    * mapping. However, let's be careful for now.
>>>    */
>>
>> LGTM.
>>
>> Andrew, could you help squash these comments into this patch? Thanks.
>>
>>>> -        if (folio_test_private(folio)) {
>>>> -            if (try_to_free_buffers(folio)) {
>>>> -                folio_clear_dirty(folio);
>>>> -                pr_info("%s: orphaned folio\n", __func__);
>>>> -                return PAGE_CLEAN;
>>>> -            }
>>>> -        }
>>>> +        VM_WARN_ON_FOLIO(true, folio);
> 
> Unexpected but better to use VM_WARN_ON_ONCE_FOLIO here.

Um, I don't think it makes much difference, because we should no longer 
hit this.

