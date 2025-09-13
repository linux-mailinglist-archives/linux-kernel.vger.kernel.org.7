Return-Path: <linux-kernel+bounces-815009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8792B55E18
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BF6A08109
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696141DE3DC;
	Sat, 13 Sep 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s8lMUvZN"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839582566
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757733988; cv=none; b=r25B2FD6aSvSMX2cbxUTHUj+BEQhphMEHLp1P/PCCQDLgkLqjrpa4eIe48MjhW0H0xPZpsBl6G2URtVUEfgXxaG5szS+GEAQUOVdIyywqY5gGmLSTvwavCeDF+EpkK/lr3unE3/wI9HIzaGSaFxs4SjG7oSUIMezvSLtatvzXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757733988; c=relaxed/simple;
	bh=ufXIhhGNY61fv/ll3s+7ydHirPh1AzwivwLHtinBWOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlllAiyEkdOjmI3DaMHKcRZ7Xdpf3iw7BMLXCmQNSuTeKUMQgeJgaWhzamTBta7NIWTuTJwJ394aziljd+GmBrVQVyO/RUaU6yAO6sMn68OXOFEF8IRwONmDWEF2zM3+ErlJqXF0OXLr3cvC23z5K7CTYdWFdq64twZPdYtaY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s8lMUvZN; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757733984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LBPemiQvLMxvPRaP1xaM0T1pppLLfrD8DNU0toXcXBo=;
	b=s8lMUvZNXSVQg4/b/wF+xJThTetnZEhAtxWpj7Y+zhMuUr6JFGkoBv3r4pcuL+hOebIMB65UGZI9826i4ydw0vQpYDNcuvsDmwrjtFgMWdyk2dCl1Y9553dbR4bcW/CmbmAuHJ52CkhntrbTiarBDpMYHoEy/rpD9NBS2rdV+M0=
Received: from 30.134.50.220(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnse-95_1757733982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 11:26:23 +0800
Message-ID: <59ddf3bc-cfc0-40ab-ae2d-859724ef6168@linux.alibaba.com>
Date: Sat, 13 Sep 2025 11:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
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
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-10-ryncsn@gmail.com>
 <0cb2bc82-1957-4efe-8c85-8558743dcf80@linux.alibaba.com>
 <CAMgjq7Bc6r2=BcAPCeVPcVJ_hP8bXTs_pya2fWg8ZL-vTG9SAg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7Bc6r2=BcAPCeVPcVJ_hP8bXTs_pya2fWg8ZL-vTG9SAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/12 20:36, Kairui Song wrote:
> On Fri, Sep 12, 2025 at 4:22 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>> On 2025/9/11 00:08, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> Shmem may replace a folio in the swap cache if the cached one doesn't
>>> fit the swapin's GFP zone. When doing so, shmem has already double
>>> checked that the swap cache folio is locked, still has the swap cache
>>> flag set, and contains the wanted swap entry. So it is impossible to
>>> fail due to an XArray mismatch. There is even a comment for that.
>>>
>>> Delete the defensive error handling path, and add a WARN_ON instead:
>>> if that happened, something has broken the basic principle of how the
>>> swap cache works, we should catch and fix that.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    mm/shmem.c | 42 ++++++++++++------------------------------
>>>    1 file changed, 12 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 410f27bc4752..5f395fab489c 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1661,13 +1661,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>>>                }
>>>
>>>                /*
>>> -              * The delete_from_swap_cache() below could be left for
>>> +              * The swap_cache_del_folio() below could be left for
>>>                 * shrink_folio_list()'s folio_free_swap() to dispose of;
>>>                 * but I'm a little nervous about letting this folio out of
>>>                 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
>>>                 * e.g. folio_mapping(folio) might give an unexpected answer.
>>>                 */
>>> -             delete_from_swap_cache(folio);
>>> +             swap_cache_del_folio(folio);
>>>                goto redirty;
>>>        }
>>>        if (nr_pages > 1)
>>> @@ -2045,7 +2045,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>>        new->swap = entry;
>>>
>>>        memcg1_swapin(entry, nr_pages);
>>> -     shadow = get_shadow_from_swap_cache(entry);
>>> +     shadow = swap_cache_get_shadow(entry);
>>
>> Again, there are still some issues with the patch split. The swapcache
>> related APIs replacement should be placed in Patch 8, otherwise there
>> will be buidling errors after applying Patch 8.
>>
>> With this issue fixed:
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
> 
> Hi Baolin
> 
> Yeah you are right, I need to move these few changes to patch 8.
> 
> BTW I also found that the WARN_ON and irq unlock needs following fix,
> the stats update need to be done with irq disabled:

Yes, indeed, I overlooked this.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 957e40caba6e..c4d491c93506 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2121,14 +2121,14 @@ static int shmem_replace_folio(struct folio
> **foliop, gfp_t gfp,
>          /* Swap cache still stores N entries instead of a high-order entry */
>          xa_lock_irq(&swap_mapping->i_pages);
>          for (i = 0; i < nr_pages; i++) {
> -               WARN_ON_ONCE(xas_store(&xas, new));
> +               WARN_ON_ONCE(xas_store(&xas, new) != old);
>                  xas_next(&xas);
>          }
> -       xa_unlock_irq(&swap_mapping->i_pages);
> 
>          mem_cgroup_replace_folio(old, new);
>          shmem_update_stats(new, nr_pages);
>          shmem_update_stats(old, -nr_pages);
> +       xa_unlock_irq(&swap_mapping->i_pages);
> 
>          folio_add_lru(new);
>          *foliop = new;


