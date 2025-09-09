Return-Path: <linux-kernel+bounces-806987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9471B49E96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ECE3A7354
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A31A9FA3;
	Tue,  9 Sep 2025 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ox6dc2GX"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096C72634
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380730; cv=none; b=aZBGUYwW5ZVWfEgR5DTt42s2qrrLAlVRFFmgbECcVw9E2GJU4rpggas+17IJdGUp8pBEb7teinEfXhWX8U2Hrw5PFs/qtVpxOZvedvzY/L+xNZ8J7ei+rdftiV0Ms6rorLwweYkYd3p/05Tn/LPETqhk2lvfJehIaTX3osSyEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380730; c=relaxed/simple;
	bh=haofq4aJulOdQW+W7u/fWtDTSsB57XYWoPUL6i2PtcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwPmNqGXeRlyZmckJvvD6yK1lafwvDXAFpfDnY4kB1wCEGoH/ezuipJ/Vb61/uLNeRjw3YzFBFfiw8kKXe/J8EX1zOWVIZz26tjxuGCUY1z3RaxUcRT8hJAljNPOjKluv8425A2QLJfpvsSKBPk8JUIDaVrhfXGhnhCXkipYmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ox6dc2GX; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757380725; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BCOMaIA3bRDs5y9C8OpoEHGFUb9T7qWgqZAgYrwfhIo=;
	b=Ox6dc2GXlsKo2AA2uBmPJq9/S45uRa+BuyTmvIcsejWtOevSLfatJ8ITFxKbBoyXK3uSJb0p8vRiW8H1HDJYFKa+8i52a81vH3W/sYrM/fpQ2cOWimJIVT83JZmVV2gcfLAoNH/X/2bK+oyMGFNQaVeoSzRPEiyEbwjwSdirHxA=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnbpUQR_1757380722 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 09:18:43 +0800
Message-ID: <8f4aa09b-f005-4def-baed-a905a99aa19f@linux.alibaba.com>
Date: Tue, 9 Sep 2025 09:18:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a
 helper
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-11-ryncsn@gmail.com>
 <f8051ae4-1b9d-42dc-8272-24a05741d86e@linux.alibaba.com>
 <CAMgjq7CQSGAhah8xwzJJUOLYEEQer63ZERsP6W-JVDCt4mSFMw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7CQSGAhah8xwzJJUOLYEEQer63ZERsP6W-JVDCt4mSFMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/8 18:44, Kairui Song wrote:
> On Mon, Sep 8, 2025 at 11:52 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/9/6 03:13, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> There are currently three swap cache users that are trying to replace an
>>> existing folio with a new one: huge memory splitting, migration, and
>>> shmem replacement. What they are doing is quite similar.
>>>
>>> Introduce a common helper for this. In later commits, they can be easily
>>> switched to use the swap table by updating this helper.
>>>
>>> The newly added helper also makes the swap cache API better defined, and
>>> debugging is easier.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>>    mm/huge_memory.c |  5 ++---
>>>    mm/migrate.c     | 11 +++--------
>>>    mm/shmem.c       | 10 ++--------
>>>    mm/swap.h        |  3 +++
>>>    mm/swap_state.c  | 32 ++++++++++++++++++++++++++++++++
>>>    5 files changed, 42 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 26cedfcd7418..a4d192c8d794 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3798,9 +3798,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>                         * NOTE: shmem in swap cache is not supported yet.
>>>                         */
>>>                        if (swap_cache) {
>>> -                             __xa_store(&swap_cache->i_pages,
>>> -                                        swap_cache_index(new_folio->swap),
>>> -                                        new_folio, 0);
>>> +                             __swap_cache_replace_folio(swap_cache, new_folio->swap,
>>> +                                                        folio, new_folio);
>>>                                continue;
>>>                        }
>>
>> IIUC, it doesn't seem like a simple function replacement here. It
>> appears that the original code has a bug: if the 'new_folio' is a large
>> folio after split, we need to iterate over each swap entry of the large
>> swapcache folio and then restore the new 'new_folio'.
>>
> 
> That should be OK. We have a check in uniform_split_supported and
> non_uniform_split_supported that swapcache folio can only be splitted
> into order0. And it seems there is no support for splitting pure
> swapcache folio now.

Ah, yes. Better to mention that in the commit message, otherwise, it 
will make people (at least for me) doubt whether this is a 
non-functional change.

With David's comments addressed, feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Maybe we can try to enable and make use of higher order split
> after this series for swapcache. I just had a try to use some hackish
> code to split random folios in the swap cache to larger order, it seems
> fine after this series.


