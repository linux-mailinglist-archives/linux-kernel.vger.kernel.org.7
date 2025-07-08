Return-Path: <linux-kernel+bounces-720947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6DAFC26A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6391AA7F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB221E0BA;
	Tue,  8 Jul 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O2b0RToN"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B021D3DF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954762; cv=none; b=SNqqp53RxSPlTUswI1K72LPXzhLdG+R49jjBGxPsPNTBibcT56QQtTonBQsb00R2GX5hxjjKWueiQ/mvu8KAH2N0t8+2x08Ly00KmhB+R4o7nO60Ii8x+jeyuosXMGOomb2XESszfHVORjMIDfYR0hj7cnybBfAPvFbetfQ4y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954762; c=relaxed/simple;
	bh=ZpRVkF24sWefdWhYdyDZmnK9tMWvSfIXfiLZvnLRqpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NL3jJS7V4I0gru/nlS9GQQcHv/2Z359XJLDKopYCRD6S4yQuHURZNH1ch7QcuVHwAganNYOirnU03unv+q94Y1qRaRFM9BJONakpWDtC14cTF/F6VZHi1bYrKofWgwrE2+MEEAk7BVRWq//09O0RNna/oDENdMtqhsOy0esaRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O2b0RToN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751954757; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YgHE/eu3q6DUgpWG6PC5BtQe1oXPiqfjAelN5RELJb4=;
	b=O2b0RToNa033QVk2zgHe7cWMePq7EEmJAWT9vLqzI9sMEc/dQXihjKBcgAdJSdRyMpfWnCQ5JL0eSmBWR0xVzvOcKsOHJ0FMrKGme7V6Xwqx3QoKEU9vBwuAB7/yc7L44rLpPxsrrMS85mh40JsAK6LvW+DyjuNN4bh2U2Dqr0U=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiKolvu_1751954438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:00:39 +0800
Message-ID: <49feb9d6-36d0-414b-b56e-29dc106596d8@linux.alibaba.com>
Date: Tue, 8 Jul 2025 14:00:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] mm/shmem, swap: avoid false positive swap cache
 lookup
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250704181748.63181-1-ryncsn@gmail.com>
 <20250704181748.63181-6-ryncsn@gmail.com>
 <17d23ed0-3b12-42a5-a5de-994f570b1bca@linux.alibaba.com>
 <CAMgjq7DAeZq2zib3q_x99BssjHDa29Pnd9YFGAqLttkED_gmSA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7DAeZq2zib3q_x99BssjHDa29Pnd9YFGAqLttkED_gmSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/7 16:04, Kairui Song wrote:
> On Mon, Jul 7, 2025 at 3:53 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Hi Kairui,
>>
>> On 2025/7/5 02:17, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> If a shmem read request's index points to the middle of a large swap
>>> entry, shmem swap in will try the swap cache lookup using the large
>>> swap entry's starting value (which is the first sub swap entry of this
>>> large entry).  This will lead to false positive lookup results, if only
>>> the first few swap entries are cached but the actual requested swap
>>> entry pointed by index is uncached. This is not a rare event as swap
>>> readahead always try to cache order 0 folios when possible.
>>>
>>> Currently, shmem will do a large entry split when it occurs, aborts
>>> due to a mismatching folio swap value, then retry the swapin from
>>> the beginning, which is a waste of CPU and adds wrong info to
>>> the readahead statistics.
>>>
>>> This can be optimized easily by doing the lookup using the right
>>> swap entry value.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>>    mm/shmem.c | 31 +++++++++++++++----------------
>>>    1 file changed, 15 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 217264315842..2ab214e2771c 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2274,14 +2274,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>        pgoff_t offset;
>>>
>>>        VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
>>> -     swap = index_entry = radix_to_swp_entry(*foliop);
>>> +     index_entry = radix_to_swp_entry(*foliop);
>>> +     swap = index_entry;
>>>        *foliop = NULL;
>>>
>>> -     if (is_poisoned_swp_entry(swap))
>>> +     if (is_poisoned_swp_entry(index_entry))
>>>                return -EIO;
>>>
>>> -     si = get_swap_device(swap);
>>> -     order = shmem_confirm_swap(mapping, index, swap);
>>> +     si = get_swap_device(index_entry);
>>> +     order = shmem_confirm_swap(mapping, index, index_entry);
>>>        if (unlikely(!si)) {
>>>                if (order < 0)
>>>                        return -EEXIST;
>>> @@ -2293,6 +2294,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>                return -EEXIST;
>>>        }
>>>
>>> +     /* index may point to the middle of a large entry, get the sub entry */
>>> +     if (order) {
>>> +             offset = index - round_down(index, 1 << order);
>>> +             swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>>> +     }
>>> +
>>>        /* Look it up and read it in.. */
>>>        folio = swap_cache_get_folio(swap, NULL, 0);
>>
>> Please drop this patch, which will cause a swapin fault dead loop.
>>
>> Assume an order-4 shmem folio has been swapped out, and the swap cache
>> holds this order-4 folio (assuming index == 0, swap.val == 0x4000).
>>
>> During swapin, if the index is 1, and the recalculation of the swap
>> value here will result in 'swap.val == 0x4001'. This will cause the
>> subsequent 'folio->swap.val != swap.val' check to fail, continuously
>> triggering a dead-loop swapin fault, ultimately causing the CPU to hang.
>>
> 
> Oh, thanks for catching that.
> 
> Clearly I wasn't thinking carefully enough on this. The problem will
> be gone if we calculate the `swap.val` based on folio_order and not
> split_order, which is currently done in patch 8.

OK. I saw patch 8. After patch 8, the logic seems correct.

> Previously there were only 4 patches so I never expected this
> problem... I can try to organize the patch order again. I was hoping
> they could be merged as one patch, some designs are supposed to work
> together so splitting the patch may cause intermediate problems like
> this.

Again, please do not combine different changes into one huge patch, 
which is _really_ hard to review and discuss. Please split your patches 
properly and ensure each patch has been tested.

> Perhaps you can help have a look at later patches, if we can just
> merge them into one? eg. merge or move patch 8 into this. Or maybe I
> need to move this patch later.

It seems that patch 5 depends on the cleanup in patch 8. If there's no 
better way to split them, I suggest merging patch 5 into patch 8.

> The performance / object size / stack usage improvements are
> shown in the commit message.


